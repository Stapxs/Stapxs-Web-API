package handler

import (
	"context"
	"strconv"

	"github.com/cloudwego/hertz/pkg/app"
	"stapxs-web-api/hertz-api/internal/service"
)

type TextHandler struct {
	service *service.TextService
}

func NewTextHandler(s *service.TextService) *TextHandler {
	return &TextHandler{service: s}
}

func (h *TextHandler) GetRandom(ctx context.Context, c *app.RequestContext) {
	c.String(200, h.service.RandomQuoteText())
}

func (h *TextHandler) GetByType(ctx context.Context, c *app.RequestContext) {
	typeParam := c.Param("type")
	idx := h.service.RandomQuoteIndex()
	quote := h.service.QuoteByIndex(idx)

	switch typeParam {
	case "text":
		c.String(200, quote.Text)
	case "json":
		c.JSON(200, map[string]any{
			"status": 200,
			"id":     idx,
			"time":   quote.Time,
			"text":   quote.Text,
		})
	case "all":
		c.JSON(200, map[string]any{
			"status": 200,
			"data":   h.service.AllQuotes(),
		})
	default:
		c.JSON(200, map[string]any{
			"status":  403,
			"message": "参数不正确",
		})
	}
}

func (h *TextHandler) GetByTypeAndID(ctx context.Context, c *app.RequestContext) {
	typeParam := c.Param("type")
	idParam := c.Param("id")

	idx, err := strconv.Atoi(idParam)
	if err != nil {
		panic("invalid id")
	}

	quote := h.service.QuoteByIndex(idx)
	switch typeParam {
	case "text":
		c.String(200, quote.Text)
	case "json":
		c.JSON(200, map[string]any{
			"status": 200,
			"id":     idx,
			"time":   quote.Time,
			"text":   quote.Text,
		})
	default:
		c.JSON(200, map[string]any{
			"status":  403,
			"message": "参数不正确",
		})
	}
}
