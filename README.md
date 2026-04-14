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
go run ./cmd/api
```

Environment variables:

- `APP_PORT` default: `3000`
- `APP_VERSION` default: `0.0.3`

## Compatibility Notes

- Response schema follows legacy behavior for phase-1 endpoints.
- Random index logic keeps the legacy off-by-one behavior (last quote may not be selected).
- `/info` currently keeps old metadata content (includes tool endpoints description only).
