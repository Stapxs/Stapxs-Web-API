package service

import (
	"encoding/json"
	"fmt"
	"io"
	"net/http"
	"strings"
	"time"
)

type InnerService struct {
	homeAddress string
	homeToken   string
	httpClient  *http.Client
}

func NewInnerService(homeAddress string, homeToken string) *InnerService {
	return &InnerService{
		homeAddress: strings.TrimRight(homeAddress, "/"),
		homeToken:   homeToken,
		httpClient:  &http.Client{Timeout: 8 * time.Second},
	}
}

func (s *InnerService) GetHomeInfo(entityID string) map[string]any {
	if s.homeAddress == "" || s.homeToken == "" {
		return map[string]any{"error": "HOME_ADDRESS 或 HOME_TOKEN 未配置"}
	}

	url := fmt.Sprintf("%s/api/states/%s", s.homeAddress, entityID)
	req, err := http.NewRequest(http.MethodGet, url, nil)
	if err != nil {
		return map[string]any{"error": err.Error()}
	}

	req.Header.Set("Authorization", "Bearer "+s.homeToken)
	req.Header.Set("Content-Type", "application/json")

	resp, err := s.httpClient.Do(req)
	if err != nil {
		return map[string]any{"error": err.Error()}
	}
	defer resp.Body.Close()

	body, err := io.ReadAll(resp.Body)
	if err != nil {
		return map[string]any{"error": err.Error()}
	}

	var payload map[string]any
	if err := json.Unmarshal(body, &payload); err != nil {
		return map[string]any{"error": string(body)}
	}

	attrsRaw, ok := payload["attributes"]
	if ok {
		if attrs, ok := attrsRaw.(map[string]any); ok {
			for k := range attrs {
				lower := strings.ToLower(k)
				if lower == "latitude" || lower == "longitude" || lower == "location" {
					attrs[k] = "removed"
				}
			}
		}
	}

	delete(payload, "context")
	return payload
}
