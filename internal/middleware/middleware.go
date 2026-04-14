package middleware

import (
	"context"
	"fmt"
	"log"
	"time"

	"github.com/cloudwego/hertz/pkg/app"
	"github.com/cloudwego/hertz/pkg/common/hlog"
)

func RequestLogger() app.HandlerFunc {
	return func(ctx context.Context, c *app.RequestContext) {
		start := time.Now()
		c.Next(ctx)

		latency := time.Since(start)
		log.Printf("%s %s status=%d latency_ms=%d", c.Method(), c.Path(), c.Response.StatusCode(), latency.Milliseconds())
	}
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
