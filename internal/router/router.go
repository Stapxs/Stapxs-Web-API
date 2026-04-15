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
	ssqqHandler *handler.SSQQHandler,
) {
	h.GET("/", rootHandler.Hello)
	h.GET("/healthz", rootHandler.Health)
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

	ssqq := h.Group("/ssqq")
	ssqq.GET("/sponsor", ssqqHandler.GetSponsorList)
	ssqq.POST("/checkKey", ssqqHandler.CheckKey)

	ssqq.GET("/umami/active", ssqqHandler.UmamiActive)
	ssqq.GET("/umami/pageviews/:unit", ssqqHandler.UmamiPageviewsNoTime)
	ssqq.GET("/umami/pageviews/:unit/:time", ssqqHandler.UmamiPageviews)
	ssqq.GET("/umami/status", ssqqHandler.UmamiStatusNoTime)
	ssqq.GET("/umami/status/:time", ssqqHandler.UmamiStatus)
	ssqq.GET("/umami/metrics/:name", ssqqHandler.UmamiMetricsNoTime)
	ssqq.GET("/umami/metrics/:name/:time", ssqqHandler.UmamiMetrics)
	ssqq.GET("/umami/events", ssqqHandler.UmamiEventsNoTime)
	ssqq.GET("/umami/events/:time", ssqqHandler.UmamiEvents)
	ssqq.GET("/umami/sessions", ssqqHandler.UmamiSessionsNoTime)
	ssqq.GET("/umami/sessions/:time", ssqqHandler.UmamiSessions)
	ssqq.POST("/umami/sessions/:time/filter", ssqqHandler.UmamiSessionsFilter)
}
