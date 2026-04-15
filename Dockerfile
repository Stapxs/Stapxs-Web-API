FROM golang:1.25-alpine AS builder

ARG GOPROXY=https://proxy.golang.org,direct
ARG GOSUMDB=sum.golang.org
ARG GONOSUMDB=

ENV GOPROXY=${GOPROXY}
ENV GOSUMDB=${GOSUMDB}
ENV GONOSUMDB=${GONOSUMDB}

WORKDIR /src

COPY go.mod go.sum ./
RUN go mod download

COPY . .
RUN CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build -tags stdjson,gjson -o /out/stapxs-web-api ./cmd/api

FROM alpine:3.21

ARG ALPINE_MIRROR=

RUN if [ -n "${ALPINE_MIRROR}" ]; then \
      printf '%s\n' "${ALPINE_MIRROR}/v3.21/main" "${ALPINE_MIRROR}/v3.21/community" > /etc/apk/repositories; \
    fi \
    && apk add --no-cache ca-certificates tzdata wget gnupg \
    && addgroup -S app \
    && adduser -S app -G app

WORKDIR /app
COPY --from=builder /out/stapxs-web-api /app/stapxs-web-api

ENV APP_PORT=3000
EXPOSE 3000

USER app

HEALTHCHECK --interval=30s --timeout=3s --start-period=10s --retries=3 \
  CMD wget -qO- "http://127.0.0.1:${APP_PORT}/healthz" >/dev/null || exit 1

ENTRYPOINT ["/app/stapxs-web-api"]
