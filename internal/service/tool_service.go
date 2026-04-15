package service

import (
	"context"
	"errors"
	"io"
	"net/http"
	"net/url"
	"regexp"
	"strconv"
	"strings"
	"time"

	"github.com/mcstatus-io/mcutil/v4/options"
	"github.com/mcstatus-io/mcutil/v4/status"
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

	extractOGMeta(string(body), back)

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

func extractOGMeta(htmlText string, back map[string]string) {
	metaTagRegex := regexp.MustCompile(`(?is)<meta\s+[^>]*>`)
	attrRegex := regexp.MustCompile(`(?is)([a-zA-Z_:][a-zA-Z0-9_:\-]*)\s*=\s*(?:"([^"]*)"|'([^']*)')`)

	metaTags := metaTagRegex.FindAllString(htmlText, -1)
	for _, metaTag := range metaTags {
		property := ""
		content := ""

		attrs := attrRegex.FindAllStringSubmatch(metaTag, -1)
		for _, attr := range attrs {
			key := strings.ToLower(strings.TrimSpace(attr[1]))
			value := strings.TrimSpace(attr[2])
			if value == "" {
				value = strings.TrimSpace(attr[3])
			}
			if key == "property" {
				property = value
			}
			if key == "content" {
				content = value
			}
		}

		if strings.HasPrefix(property, "og:") {
			back[property] = content
		}
	}
}
