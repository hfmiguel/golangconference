# Builder stage
FROM golang:1.21.0-alpine as builder
ARG CGO_ENABLED=0
ARG GOOS=linux
WORKDIR /app

COPY *.go .
RUN go mod init gofelix && go mod tidy
COPY go.mod go.sum ./
RUN go mod download && go build -ldflags '-w -s' -a -installsuffix cgo -o /gofelix

# Final stage
FROM scratch
WORKDIR /app
COPY --from=builder /gofelix /http-server
ENTRYPOINT ["/http-server"]
