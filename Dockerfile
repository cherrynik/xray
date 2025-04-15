FROM golang:alpine AS builder

WORKDIR /app

COPY go.mod go.sum main.go ./

RUN go mod tidy

COPY ./input ./input

ENTRYPOINT go run ./ --datapath=./input && \
  cp geosite.dat ./output/geosite.dat && \
  chmod 644 ./output/geosite.dat
