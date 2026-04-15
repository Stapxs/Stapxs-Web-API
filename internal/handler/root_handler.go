package handler

import (
	"context"
	"math/rand"

	"github.com/cloudwego/hertz/pkg/app"
)

type RootHandler struct {
	appVersion string
}

func NewRootHandler(appVersion string) *RootHandler {
	return &RootHandler{appVersion: appVersion}
}

func (h *RootHandler) Hello(ctx context.Context, c *app.RequestContext) {
	welcomeStr := []string{
		"欢迎使用 Stapxs Web API！",
		"这是 Stapxs Web API！",
		"阿巴啊巴，请随便看 ……",
		"客官要来点茶么 ——",
	}

	msg := welcomeStr[rand.Intn(len(welcomeStr)-1)]
	c.JSON(200, map[string]any{
		"title":   "Stpaxs Web API",
		"msg":     msg,
		"version": h.appVersion,
	})
}

func (h *RootHandler) Health(ctx context.Context, c *app.RequestContext) {
	c.JSON(200, map[string]any{
		"status":  "ok",
		"version": h.appVersion,
	})
}

func (h *RootHandler) Info(ctx context.Context, c *app.RequestContext) {
	c.JSON(200, []any{
		map[string]any{
			"type":        "text",
			"address":     []string{"/text/ss-ana", "/text/ss-ana/:type", "/text/ss-ana/:type/:id"},
			"name":        "获取林槐语录",
			"description": "获取林槐语录，参数可缺省。",
		},
		map[string]any{
			"type":        "tool",
			"address":     "/tool/page-info/:link",
			"name":        "链接预览",
			"description": "获取页面的 The Open Graph protocol 媒体信息。",
		},
		map[string]any{
			"type":        "tool",
			"address":     "/tool/mc-info/:link",
			"name":        "Minecraft 服务器列表 Ping",
			"description": "获取 Minecraft List Ping 返回的内容。",
		},
		map[string]any{
			"type":        "inner",
			"address":     "/inner/home/:id",
			"name":        "Home Assistant 实体信息",
			"description": "获取 Home Assistant 实体状态并移除敏感字段。",
		},
		map[string]any{
			"type":        "ssqq",
			"address":     "/ssqq/sponsor",
			"name":        "爱发电赞助者信息",
			"description": "获取爱发电赞助者列表。",
		},
		map[string]any{
			"type":        "ssqq",
			"address":     "/ssqq/checkKey",
			"name":        "GPG 密钥校验",
			"description": "验证并签名密钥请求。",
		},
		map[string]any{
			"type":        "ssqq",
			"address":     "/ssqq/umami/*",
			"name":        "Umami 统计接口",
			"description": "站点访问统计与会话分析接口。",
		},
	})
}
