# Stage 1: Build the Go app
FROM golang:1.20-alpine AS builder
WORKDIR /src
COPY src/ .
RUN CGO_ENABLED=0 GOOS=linux go build -a -installsuffix cgo -o app .

# Stage 2: Create the minimal image
FROM scratch
COPY --from=builder /src/app /app
ENTRYPOINT ["/app"]
