FROM golang:alpine AS builder

RUN apk update && apk add --no-cache git

WORKDIR /app

COPY go.mod go.sum main.go ./

RUN go mod tidy

COPY ./input /app/input

ENTRYPOINT go run ./ --datapath=./input && \
  cp geosite.dat ./output/geosite.dat && \
  chmod 644 ./output/geosite.dat
