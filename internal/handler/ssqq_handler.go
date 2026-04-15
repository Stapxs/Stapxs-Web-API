package handler

import (
	"context"
	"encoding/json"
	"strings"

	"github.com/cloudwego/hertz/pkg/app"
	"stapxs-web-api/hertz-api/internal/service"
)

type SSQQHandler struct {
	service *service.SSQQService
}

func NewSSQQHandler(s *service.SSQQService) *SSQQHandler {
	return &SSQQHandler{service: s}
}

func (h *SSQQHandler) GetSponsorList(ctx context.Context, c *app.RequestContext) {
	c.JSON(200, h.service.GetSponsorList())
}

func (h *SSQQHandler) CheckKey(ctx context.Context, c *app.RequestContext) {
	var body map[string]any
	if err := json.Unmarshal(c.Request.Body(), &body); err != nil {
		c.JSON(200, map[string]any{"error": "缺少参数"})
		return
	}
	c.JSON(200, h.service.CheckKey(body))
}

func (h *SSQQHandler) UmamiActive(ctx context.Context, c *app.RequestContext) {
	c.JSON(200, h.service.Umami().GetActive())
}

func (h *SSQQHandler) UmamiPageviewsNoTime(ctx context.Context, c *app.RequestContext) {
	unit := c.Param("unit")
	c.JSON(200, h.service.Umami().GetPageviews("", unit, readQuery(c)))
}

func (h *SSQQHandler) UmamiPageviews(ctx context.Context, c *app.RequestContext) {
	unit := c.Param("unit")
	timeRange := c.Param("time")
	c.JSON(200, h.service.Umami().GetPageviews(timeRange, unit, readQuery(c)))
}

func (h *SSQQHandler) UmamiStatusNoTime(ctx context.Context, c *app.RequestContext) {
	c.JSON(200, h.service.Umami().GetStatus("", readQuery(c)))
}

func (h *SSQQHandler) UmamiStatus(ctx context.Context, c *app.RequestContext) {
	timeRange := c.Param("time")
	c.JSON(200, h.service.Umami().GetStatus(timeRange, readQuery(c)))
}

func (h *SSQQHandler) UmamiMetricsNoTime(ctx context.Context, c *app.RequestContext) {
	name := c.Param("name")
	c.JSON(200, h.service.Umami().GetMetrics(name, "", readQuery(c)))
}

func (h *SSQQHandler) UmamiMetrics(ctx context.Context, c *app.RequestContext) {
	name := c.Param("name")
	timeRange := c.Param("time")
	c.JSON(200, h.service.Umami().GetMetrics(name, timeRange, readQuery(c)))
}

func (h *SSQQHandler) UmamiEventsNoTime(ctx context.Context, c *app.RequestContext) {
	c.JSON(200, h.service.Umami().GetEvents(""))
}

func (h *SSQQHandler) UmamiEvents(ctx context.Context, c *app.RequestContext) {
	timeRange := c.Param("time")
	c.JSON(200, h.service.Umami().GetEvents(timeRange))
}

func (h *SSQQHandler) UmamiSessionsNoTime(ctx context.Context, c *app.RequestContext) {
	c.JSON(200, h.service.Umami().GetSessions("", map[string]any{}))
}

func (h *SSQQHandler) UmamiSessions(ctx context.Context, c *app.RequestContext) {
	timeRange := c.Param("time")
	c.JSON(200, h.service.Umami().GetSessions(timeRange, map[string]any{}))
}

func (h *SSQQHandler) UmamiSessionsFilter(ctx context.Context, c *app.RequestContext) {
	timeRange := c.Param("time")
	var filter map[string]any
	if err := json.Unmarshal(c.Request.Body(), &filter); err != nil {
		filter = map[string]any{}
	}
	c.JSON(200, h.service.Umami().GetSessions(timeRange, filter))
}

func readQuery(c *app.RequestContext) map[string]any {
	result := map[string]any{}
	c.QueryArgs().VisitAll(func(key, value []byte) {
		k := strings.TrimSpace(string(key))
		if k == "" {
			return
		}
		result[k] = string(value)
	})
	return result
}
