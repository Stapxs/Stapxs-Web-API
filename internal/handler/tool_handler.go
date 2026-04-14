package handler

import (
	"context"
	"strings"

	"github.com/cloudwego/hertz/pkg/app"
	"stapxs-web-api/hertz-api/internal/service"
)

type ToolHandler struct {
	service *service.ToolService
}

func NewToolHandler(s *service.ToolService) *ToolHandler {
	return &ToolHandler{service: s}
}

func (h *ToolHandler) GetPageInfo(ctx context.Context, c *app.RequestContext) {
	link := c.Param("link")
	link = strings.TrimPrefix(link, "/")
	c.JSON(200, h.service.GetPageInfo(link))
}

func (h *ToolHandler) GetMinecraftInfo(ctx context.Context, c *app.RequestContext) {
	link := c.Param("link")
	c.JSON(200, h.service.GetMinecraftInfo(link))
}
