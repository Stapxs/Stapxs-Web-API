package service

import (
	"bytes"
	"context"
	"errors"
	"io"
	"net/http"
	"net/url"
	"strconv"
	"strings"
	"time"

	"github.com/mcstatus-io/mcutil/v4/options"
	"github.com/mcstatus-io/mcutil/v4/status"
	"golang.org/x/net/html"
)

type ToolService struct {
	httpClient *http.Client
}

func NewToolService() *ToolService {
	return &ToolService{
		httpClient: &http.Client{Timeout: 8 * time.Second},
	}
}

func (s *ToolService) GetPageInfo(rawLink string) map[string]string {
	back := map[string]string{}

	decodedLink, err := url.PathUnescape(rawLink)
	if err != nil {
		back["error"] = err.Error()
		return back
	}
	decodedLink = normalizeURL(decodedLink)

	resp, err := s.httpClient.Get(decodedLink)
	if err != nil {
		back["error"] = err.Error()
		return back
	}
	defer resp.Body.Close()

	contentType := strings.ToLower(resp.Header.Get("Content-Type"))
	if !strings.Contains(contentType, "text/html") {
		back["error"] = "链接内容不是有效的 HTML 页面。"
		return back
	}

	body, err := io.ReadAll(resp.Body)
	if err != nil {
		back["error"] = err.Error()
		return back
	}

	tokenizer := html.NewTokenizer(bytes.NewReader(body))
	for {
		tokenType := tokenizer.Next()
		if tokenType == html.ErrorToken {
			break
		}

		token := tokenizer.Token()
		if tokenType != html.StartTagToken || token.Data != "meta" {
			continue
		}

		property := ""
		content := ""
		for _, attr := range token.Attr {
			if attr.Key == "property" {
				property = attr.Val
			}
			if attr.Key == "content" {
				content = attr.Val
			}
		}

		if strings.HasPrefix(property, "og:") {
			back[property] = content
		}
	}

	return back
}

func normalizeURL(link string) string {
	if strings.HasPrefix(link, "https:/") && !strings.HasPrefix(link, "https://") {
		return strings.Replace(link, "https:/", "https://", 1)
	}
	if strings.HasPrefix(link, "http:/") && !strings.HasPrefix(link, "http://") {
		return strings.Replace(link, "http:/", "http://", 1)
	}
	return link
}

func (s *ToolService) GetMinecraftInfo(link string) map[string]any {
	host, port, err := parseAddress(link)
	if err != nil {
		return map[string]any{
			"status": 500,
			"data":   err.Error(),
		}
	}

	ctx, cancel := context.WithTimeout(context.Background(), 3*time.Second)
	defer cancel()

	res, err := status.Modern(ctx, host, port, options.StatusModern{Timeout: 3 * time.Second})
	if err != nil {
		return map[string]any{
			"status": 500,
			"data":   err.Error(),
		}
	}

	return map[string]any{
		"status": 200,
		"data":   res,
	}
}

func parseAddress(link string) (string, uint16, error) {
	parts := strings.Split(link, ":")
	host := parts[0]
	if host == "" {
		return "", 0, errors.New("invalid host")
	}

	if len(parts) < 2 || parts[1] == "" {
		return host, 25565, nil
	}

	portValue, err := strconv.Atoi(parts[1])
	if err != nil || portValue <= 0 || portValue > 65535 {
		return "", 0, errors.New("invalid port")
	}

	return host, uint16(portValue), nil
}
