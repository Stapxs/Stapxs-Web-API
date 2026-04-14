package router

import (
	"github.com/cloudwego/hertz/pkg/app/server"
	"stapxs-web-api/hertz-api/internal/handler"
)

func Register(h *server.Hertz, rootHandler *handler.RootHandler, textHandler *handler.TextHandler) {
	h.GET("/", rootHandler.Hello)
	h.GET("/info", rootHandler.Info)

	text := h.Group("/text")
	text.GET("/ss-ana", textHandler.GetRandom)
	text.GET("/ss-ana/:type", textHandler.GetByType)
	text.GET("/ss-ana/:type/:id", textHandler.GetByTypeAndID)
}
