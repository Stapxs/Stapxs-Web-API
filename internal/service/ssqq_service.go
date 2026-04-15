package service

import (
	"bytes"
	"crypto/md5"
	"encoding/hex"
	"encoding/json"
	"fmt"
	"io"
	"net/http"
	"os"
	"os/exec"
	"regexp"
	"strconv"
	"time"

	"stapxs-web-api/hertz-api/internal/assets"
)

type SSQQService struct {
	afdToken   string
	afdUserID  string
	gpgSignKey string
	umami      *UmamiService
	http       *http.Client
	allowed    map[string]struct{}
}

func NewSSQQService(afdToken, afdUserID, gpgSignKey string, umami *UmamiService) (*SSQQService, error) {
	allowed := map[string]struct{}{}
	if len(assets.SSQQKeysJSON) > 0 {
		var keys []string
		if json.Unmarshal(assets.SSQQKeysJSON, &keys) == nil {
			for _, k := range keys {
				allowed[k] = struct{}{}
			}
		}
	}

	return &SSQQService{
		afdToken:   afdToken,
		afdUserID:  afdUserID,
		gpgSignKey: gpgSignKey,
		umami:      umami,
		http:       &http.Client{Timeout: 12 * time.Second},
		allowed:    allowed,
	}, nil
}

func (s *SSQQService) GetSponsorList() any {
	if s.afdToken == "" || s.afdUserID == "" {
		return map[string]any{"error": "AFD 配置缺失"}
	}

	params := map[string]any{"page": 1, "per_page": 100}
	paramsStr, _ := json.Marshal(params)
	timestamp := time.Now().Unix()
	signRaw := fmt.Sprintf("%sparams%sts%duser_id%s", s.afdToken, string(paramsStr), timestamp, s.afdUserID)
	h := md5.Sum([]byte(signRaw))
	sign := hex.EncodeToString(h[:])

	body := map[string]any{
		"user_id": s.afdUserID,
		"ts":      timestamp,
		"sign":    sign,
		"params":  string(paramsStr),
	}
	bodyJSON, _ := json.Marshal(body)

	req, _ := http.NewRequest(http.MethodPost, "https://www.ifdian.net/api/open/query-sponsor", bytes.NewReader(bodyJSON))
	req.Header.Set("Content-Type", "application/json")
	resp, err := s.http.Do(req)
	if err != nil {
		return map[string]any{"error": err.Error()}
	}
	defer resp.Body.Close()
	raw, _ := io.ReadAll(resp.Body)

	var out map[string]any
	if err := json.Unmarshal(raw, &out); err != nil {
		return map[string]any{"error": string(raw)}
	}

	ec, _ := toInt(out["ec"])
	if ec != 200 {
		em, _ := out["em"].(string)
		if em == "" {
			em = "请求失败"
		}
		return map[string]any{"error": em}
	}

	data, _ := out["data"].(map[string]any)
	listRaw, _ := data["list"].([]any)
	mapped := make([]map[string]any, 0, len(listRaw))
	for _, item := range listRaw {
		entry, _ := item.(map[string]any)
		currentPlan, _ := entry["current_plan"].(map[string]any)
		userInfo, _ := entry["user"].(map[string]any)
		mapped = append(mapped, map[string]any{
			"current_plan":  currentPlan["name"],
			"last_pay_time": entry["last_pay_time"],
			"user": map[string]any{
				"name":   userInfo["name"],
				"avatar": userInfo["avatar"],
			},
		})
	}

	return map[string]any{
		"count": data["total_count"],
		"list":  mapped,
	}
}

func (s *SSQQService) CheckKey(body map[string]any) any {
	key, _ := body["key"].(string)
	timestamp := fmt.Sprintf("%v", body["timestamp"])
	if key == "" || timestamp == "" || timestamp == "\u003cnil\u003e" {
		return map[string]any{"error": "缺少参数"}
	}
	if !regexp.MustCompile(`^\d{10}$`).MatchString(timestamp) {
		return map[string]any{"error": "操作失败"}
	}
	ts, _ := strconv.ParseInt(timestamp, 10, 64)
	if abs(time.Now().Unix()-ts) > 60 {
		return map[string]any{"error": "操作失败"}
	}

	tmp, err := os.CreateTemp("", "key-*.asc")
	if err != nil {
		return map[string]any{"error": "操作失败"}
	}
	defer os.Remove(tmp.Name())
	if _, err := tmp.WriteString(key); err != nil {
		return map[string]any{"error": "操作失败"}
	}
	tmp.Close()

	decryptCmd := exec.Command("gpg", "--decrypt", "--batch", tmp.Name())
	decrypted, err := decryptCmd.Output()
	if err != nil {
		return map[string]any{"error": "操作失败"}
	}
	decryptedKey := string(bytes.TrimSpace(decrypted))
	if _, ok := s.allowed[decryptedKey]; !ok {
		return map[string]any{"error": "操作失败"}
	}

	if s.gpgSignKey == "" {
		return map[string]any{"error": "操作失败"}
	}

	signCmd := exec.Command("gpg", "--armour", "--detach-sign", "--local-user", s.gpgSignKey, "--batch", "--passphrase", "")
	signCmd.Stdin = bytes.NewBufferString("SUCCESS")
	signed, err := signCmd.Output()
	if err != nil {
		return map[string]any{"error": "操作失败"}
	}
	return map[string]any{"signature": string(signed)}
}

func (s *SSQQService) Umami() *UmamiService {
	return s.umami
}

func toInt(v any) (int, bool) {
	switch t := v.(type) {
	case float64:
		return int(t), true
	case int:
		return t, true
	case int64:
		return int(t), true
	default:
		return 0, false
	}
}

func abs(v int64) int64 {
	if v < 0 {
		return -v
	}
	return v
}
