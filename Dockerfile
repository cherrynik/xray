FROM golang:alpine AS builder

RUN apk update && apk add --no-cache git

WORKDIR /app

COPY . .

RUN go mod tidy

COPY ./input /app/input

CMD ["sh", "-c", "go run ./ --datapath=./input && cp geosite.dat ./output/geosite.dat && chmod 644 ./output/geosite.dat"]
