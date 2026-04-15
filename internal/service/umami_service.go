package service

import (
	"bytes"
	"encoding/json"
	"fmt"
	"io"
	"net/http"
	"net/url"
	"regexp"
	"strings"
	"sync"
	"time"
)

type UmamiService struct {
	address   string
	siteID    string
	user      string
	password  string
	http      *http.Client
	token     string
	tokenLock sync.Mutex
}

func NewUmamiService(siteID, user, password string) *UmamiService {
	return &UmamiService{
		address:  "https://status.stapxs.cn/api",
		siteID:   siteID,
		user:     user,
		password: password,
		http: &http.Client{
			Timeout: 12 * time.Second,
		},
	}
}

func (s *UmamiService) GetActive() any {
	return s.getData(fmt.Sprintf("/websites/%s/active", s.siteID), map[string]any{})
}

func (s *UmamiService) GetPageviews(timeRange, unit string, query map[string]any) any {
	timeRange = ensureTimeRange(timeRange)
	if !isValidTimeRange(timeRange) {
		return map[string]any{"error": "参数 time 格式错误，正确格式为 start-end（时间戳，毫秒）"}
	}
	if containsForbiddenType(query, "country", "region", "city") || query["unit"] != nil {
		return map[string]any{"error": "请求参数中包含不被允许的字段"}
	}
	startAt, endAt := splitTimeRange(timeRange)
	params := map[string]any{"startAt": startAt, "endAt": endAt, "unit": unit}
	mergeMap(params, query)
	return s.getData(fmt.Sprintf("/websites/%s/pageviews", s.siteID), params)
}

func (s *UmamiService) GetStatus(timeRange string, query map[string]any) any {
	timeRange = ensureTimeRange(timeRange)
	if !isValidTimeRange(timeRange) {
		return map[string]any{"error": "参数 time 格式错误，正确格式为 start-end（时间戳，毫秒）"}
	}
	if containsForbiddenType(query, "country", "region", "city") {
		return map[string]any{"error": "请求参数中包含不被允许的字段"}
	}
	startAt, endAt := splitTimeRange(timeRange)
	params := map[string]any{"startAt": startAt, "endAt": endAt}
	mergeMap(params, query)
	return s.getData(fmt.Sprintf("/websites/%s/stats", s.siteID), params)
}

func (s *UmamiService) GetMetrics(name, timeRange string, query map[string]any) any {
	timeRange = ensureTimeRange(timeRange)
	if !isValidTimeRange(timeRange) {
		return map[string]any{"error": "参数 time 格式错误，正确格式为 start-end（时间戳，毫秒）"}
	}
	if name == "host" || inStringSet(name, "country", "region", "city") {
		return map[string]any{"error": fmt.Sprintf("请求的数据类型 %s 不被允许", name)}
	}
	if query["type"] != nil {
		return map[string]any{"error": "请求参数中包含不被允许的字段"}
	}
	startAt, endAt := splitTimeRange(timeRange)
	params := map[string]any{"startAt": startAt, "endAt": endAt, "type": name}
	mergeMap(params, query)
	return s.getData(fmt.Sprintf("/websites/%s/metrics", s.siteID), params)
}

func (s *UmamiService) GetEvents(timeRange string) any {
	timeRange = ensureTimeRange(timeRange)
	if !isValidTimeRange(timeRange) {
		return map[string]any{"error": "参数 time 格式错误，正确格式为 start-end（时间戳，毫秒）"}
	}
	startAt, endAt := splitTimeRange(timeRange)
	baseParams := map[string]any{"startAt": startAt, "endAt": endAt}
	data := s.getData(fmt.Sprintf("/websites/%s/event-data/properties", s.siteID), baseParams)

	items, ok := data.([]any)
	if !ok {
		return data
	}

	result := make([]map[string]any, 0, len(items))
	for _, item := range items {
		event, ok := item.(map[string]any)
		if !ok {
			continue
		}
		eventName, _ := event["eventName"].(string)
		if eventName == "link_view" {
			continue
		}
		propertyName, _ := event["propertyName"].(string)
		detailParams := map[string]any{"startAt": startAt, "endAt": endAt, "eventName": eventName, "propertyName": propertyName}
		event["details"] = s.getData(fmt.Sprintf("/websites/%s/event-data/values", s.siteID), detailParams)
		result = append(result, event)
	}
	return result
}

func (s *UmamiService) GetSessions(timeRange string, filter map[string]any) any {
	timeRange = ensureTimeRange(timeRange)
	if !isValidTimeRange(timeRange) {
		return map[string]any{"error": "参数 time 格式错误，正确格式为 start-end（时间戳，毫秒）"}
	}
	startAt, endAt := splitTimeRange(timeRange)
	baseParams := map[string]any{"startAt": startAt, "endAt": endAt}
	mergeMap(baseParams, filter)
	data := s.getData(fmt.Sprintf("/websites/%s/session-data/properties", s.siteID), baseParams)

	items, ok := data.([]any)
	if !ok {
		return data
	}
	result := make([]map[string]any, 0, len(items))
	for _, item := range items {
		session, ok := item.(map[string]any)
		if !ok {
			continue
		}
		propertyName, _ := session["propertyName"].(string)
		detailParams := map[string]any{"startAt": startAt, "endAt": endAt, "propertyName": propertyName}
		mergeMap(detailParams, filter)
		session["details"] = s.getData(fmt.Sprintf("/websites/%s/session-data/values", s.siteID), detailParams)
		result = append(result, session)
	}
	return result
}

func (s *UmamiService) getData(path string, params map[string]any) any {
	if strings.TrimSpace(s.siteID) == "" || strings.TrimSpace(s.user) == "" || strings.TrimSpace(s.password) == "" {
		return map[string]any{"error": "Umami 配置缺失"}
	}

	token, err := s.ensureToken()
	if err != nil {
		return map[string]any{"error": err.Error()}
	}

	u, _ := url.Parse(s.address + path)
	q := u.Query()
	for k, v := range params {
		q.Set(k, fmt.Sprintf("%v", v))
	}
	u.RawQuery = q.Encode()

	req, _ := http.NewRequest(http.MethodGet, u.String(), nil)
	req.Header.Set("Content-Type", "application/json")
	req.Header.Set("Authorization", "Bearer "+token)

	resp, err := s.http.Do(req)
	if err != nil {
		return map[string]any{"error": err.Error()}
	}
	defer resp.Body.Close()
	body, _ := io.ReadAll(resp.Body)

	var out any
	if err := json.Unmarshal(body, &out); err != nil {
		return map[string]any{"error": string(body)}
	}
	return out
}

func (s *UmamiService) ensureToken() (string, error) {
	s.tokenLock.Lock()
	defer s.tokenLock.Unlock()

	if s.token != "" {
		ok, _ := s.checkToken(s.token)
		if ok {
			return s.token, nil
		}
	}

	token, err := s.getToken()
	if err != nil {
		return "", err
	}
	s.token = token
	return token, nil
}

func (s *UmamiService) getToken() (string, error) {
	payload := map[string]string{"username": s.user, "password": s.password}
	buf, _ := json.Marshal(payload)
	req, _ := http.NewRequest(http.MethodPost, s.address+"/auth/login", bytes.NewReader(buf))
	req.Header.Set("Content-Type", "application/json")
	resp, err := s.http.Do(req)
	if err != nil {
		return "", err
	}
	defer resp.Body.Close()
	body, _ := io.ReadAll(resp.Body)

	var out map[string]any
	if err := json.Unmarshal(body, &out); err != nil {
		return "", fmt.Errorf("Umami 登录失败")
	}
	token, _ := out["token"].(string)
	if token == "" {
		return "", fmt.Errorf("Umami 登录失败")
	}
	return token, nil
}

func (s *UmamiService) checkToken(token string) (bool, error) {
	req, _ := http.NewRequest(http.MethodPost, s.address+"/auth/verify", nil)
	req.Header.Set("Content-Type", "application/json")
	req.Header.Set("Authorization", "Bearer "+token)
	resp, err := s.http.Do(req)
	if err != nil {
		return false, err
	}
	defer resp.Body.Close()
	body, _ := io.ReadAll(resp.Body)

	var out map[string]any
	if err := json.Unmarshal(body, &out); err != nil {
		return false, nil
	}
	_, exists := out["id"]
	return exists, nil
}

func ensureTimeRange(timeRange string) string {
	if strings.TrimSpace(timeRange) != "" {
		return timeRange
	}
	end := time.Now().UnixMilli()
	start := end - 86400000
	return fmt.Sprintf("%d-%d", start, end)
}

func isValidTimeRange(timeRange string) bool {
	parts := strings.Split(timeRange, "-")
	if len(parts) != 2 {
		return false
	}
	r := regexp.MustCompile(`^\d{13}$`)
	return r.MatchString(parts[0]) && r.MatchString(parts[1])
}

func splitTimeRange(timeRange string) (string, string) {
	parts := strings.Split(timeRange, "-")
	return parts[0], parts[1]
}

func mergeMap(dst map[string]any, src map[string]any) {
	for k, v := range src {
		dst[k] = v
	}
}

func inStringSet(target string, list ...string) bool {
	for _, item := range list {
		if target == item {
			return true
		}
	}
	return false
}

func containsForbiddenType(query map[string]any, forbidden ...string) bool {
	v, exists := query["type"]
	if !exists {
		return false
	}
	value := fmt.Sprintf("%v", v)
	for _, item := range forbidden {
		if value == item {
			return true
		}
	}
	return false
}
