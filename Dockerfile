FROM golang:1.19.1 AS builder

WORKDIR /go/src/github.com/stellar/starbridge
COPY go.mod go.sum ./
RUN go mod download
COPY . ./
RUN go install github.com/stellar/starbridge

FROM ubuntu:22.04
RUN apt-get update
RUN apt-get install -y ca-certificates
COPY --from=builder /go/bin/starbridge ./
ENTRYPOINT ["./starbridge"]
