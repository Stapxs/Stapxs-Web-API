package router

import (
	"github.com/cloudwego/hertz/pkg/app/server"
	"stapxs-web-api/hertz-api/internal/handler"
)

func Register(
	h *server.Hertz,
	rootHandler *handler.RootHandler,
	textHandler *handler.TextHandler,
	toolHandler *handler.ToolHandler,
	innerHandler *handler.InnerHandler,
) {
	h.GET("/", rootHandler.Hello)
	h.GET("/info", rootHandler.Info)

	text := h.Group("/text")
	text.GET("/ss-ana", textHandler.GetRandom)
	text.GET("/ss-ana/:type", textHandler.GetByType)
	text.GET("/ss-ana/:type/:id", textHandler.GetByTypeAndID)

	tool := h.Group("/tool")
	tool.GET("/page-info/:link", toolHandler.GetPageInfo)
	tool.GET("/page-info/*link", toolHandler.GetPageInfo)
	tool.GET("/mc-info/:link", toolHandler.GetMinecraftInfo)

	inner := h.Group("/inner")
	inner.GET("/home/:id", innerHandler.GetHomeInfo)
}
