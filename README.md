# Hertz API (Phase 1 MVP)

This service is the Go Hertz rewrite of the legacy Node.js API.
Current implementation scope:

- `GET /`
- `GET /info`
- `GET /text/ss-ana`
- `GET /text/ss-ana/:type`
- `GET /text/ss-ana/:type/:id`

## Run

```bash
go mod tidy
go run -tags stdjson,gjson ./cmd/api
```

If you compile manually, keep the same build tags:

```bash
go build -tags stdjson,gjson ./...
```

Health check endpoint:

```bash
GET /healthz
```

## Docker

Build image:

```bash
docker build -t stapxs-web-api:latest .
```

Run container:

```bash
docker run --rm -p 3000:3000 --env-file .env stapxs-web-api:latest
```

Container healthcheck uses:

```bash
http://127.0.0.1:${APP_PORT}/healthz
```

Environment variables:

- `APP_PORT` default: `3000`
- `APP_VERSION` default: `0.0.3`

## Compatibility Notes

- Response schema follows legacy behavior for phase-1 endpoints.
- Random index logic keeps the legacy off-by-one behavior (last quote may not be selected).
- `/info` currently keeps old metadata content (includes tool endpoints description only).
