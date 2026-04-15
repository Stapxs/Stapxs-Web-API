package middleware

import (
	"context"
	"fmt"
	"log"
	"net"
	"strings"
	"time"

	"github.com/cloudwego/hertz/pkg/app"
	"github.com/cloudwego/hertz/pkg/common/hlog"
)

func RequestLogger() app.HandlerFunc {
	return func(ctx context.Context, c *app.RequestContext) {
		path := string(c.Path())
		start := time.Now()
		c.Next(ctx)

		latency := time.Since(start)
		xff := strings.TrimSpace(string(c.Request.Header.Peek("X-Forwarded-For")))
		xri := strings.TrimSpace(string(c.Request.Header.Peek("X-Real-IP")))
		ip := c.ClientIP()
		if xff != "" {
			ip = strings.TrimSpace(strings.Split(xff, ",")[0])
		} else if xri != "" {
			ip = xri
		}

		if path == "/healthz" && isLoopbackIP(ip) {
			return
		}

		log.Printf(
			"[%s] %s %d(%d ms) <- %s",
			c.Method(),
			path,
			c.Response.StatusCode(),
			latency.Milliseconds(),
			ip,
		)
	}
}

func isLoopbackIP(ip string) bool {
	ip = strings.TrimSpace(ip)
	if ip == "" {
		return false
	}

	if strings.Contains(ip, ",") {
		ip = strings.TrimSpace(strings.Split(ip, ",")[0])
	}

	parsed := net.ParseIP(ip)
	if parsed != nil {
		return parsed.IsLoopback()
	}

	return strings.EqualFold(ip, "localhost")
}

func Recovery() app.HandlerFunc {
	return func(ctx context.Context, c *app.RequestContext) {
		defer func() {
			if r := recover(); r != nil {
				hlog.Errorf("panic recovered: %v", r)
				c.JSON(500, map[string]string{"error": fmt.Sprintf("%v", r)})
				c.Abort()
			}
		}()

		c.Next(ctx)
	}
}
