package main

import (
	"context"
	"fmt"
	"math/rand"
	"os"
	"os/signal"
	"syscall"
	"time"

	"github.com/cloudwego/hertz/pkg/app"
	"github.com/cloudwego/hertz/pkg/app/server"

	"stapxs-web-api/hertz-api/internal/config"
	"stapxs-web-api/hertz-api/internal/handler"
	"stapxs-web-api/hertz-api/internal/middleware"
	"stapxs-web-api/hertz-api/internal/router"
	"stapxs-web-api/hertz-api/internal/service"
)

func main() {
	rand.Seed(time.Now().UnixNano())

	cfg := config.Load()

	textService, err := service.NewTextService()
	if err != nil {
		panic(err)
	}

	rootHandler := handler.NewRootHandler(cfg.AppVersion)
	textHandler := handler.NewTextHandler(textService)

	h := server.New(server.WithHostPorts(fmt.Sprintf(":%s", cfg.Port)))
	h.Use(middleware.Recovery())
	h.Use(middleware.RequestLogger())
	h.Use(func(ctx context.Context, c *app.RequestContext) {
		c.Header("Access-Control-Allow-Origin", "*")
		c.Next(ctx)
	})

	router.Register(h, rootHandler, textHandler)

	go h.Spin()
	waitForShutdown(h)
}

func waitForShutdown(h *server.Hertz) {
	ch := make(chan os.Signal, 1)
	signal.Notify(ch, syscall.SIGINT, syscall.SIGTERM)
	<-ch
	h.Close()
}
