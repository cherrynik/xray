FROM golang:alpine AS builder

RUN apk update && apk add --no-cache git

WORKDIR /app

RUN git clone https://github.com/v2fly/domain-list-community.git .

RUN go mod tidy

COPY ./input /app/input

CMD ["sh", "-c", "go run ./ --datapath=./input && cp dlc.dat ./output/custom.dat && chmod 644 ./output/custom.dat"]
