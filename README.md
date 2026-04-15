# Stapxs Web API

```bash
go mod tidy
go run -tags stdjson,gjson ./cmd/api
```

```bash
docker build -t stapxs-web-api:latest .
```

```bash
docker run --rm -p 3000:3000 --env-file .env stapxs-web-api:latest
```

```bash
cp .env.example .env
docker compose up -d --build
docker compose ps
docker compose logs -f api
```

```bash
# 镜像选项
BUILD_GOPROXY=https://goproxy.cn,direct
BUILD_GOSUMDB=off
BUILD_GONOSUMDB=*
BUILD_ALPINE_MIRROR=https://mirrors.aliyun.com/alpine
```