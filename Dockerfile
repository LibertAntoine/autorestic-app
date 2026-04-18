FROM ghcr.io/cupcakearmy/autorestic:latest

RUN apk add --no-cache postgresql16-client bash

WORKDIR /data

