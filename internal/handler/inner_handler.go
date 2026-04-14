package handler

import (
	"context"

	"github.com/cloudwego/hertz/pkg/app"
	"stapxs-web-api/hertz-api/internal/service"
)

type InnerHandler struct {
	service *service.InnerService
}

func NewInnerHandler(s *service.InnerService) *InnerHandler {
	return &InnerHandler{service: s}
}

func (h *InnerHandler) GetHomeInfo(ctx context.Context, c *app.RequestContext) {
	id := c.Param("id")
	c.JSON(200, h.service.GetHomeInfo(id))
}
