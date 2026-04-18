FROM cupcakearmy/autorestic:1.8

RUN apk add --no-cache postgresql16-client bash

WORKDIR /data

