FROM cupcakearmy/autorestic:1.8

RUN apk add --no-cache postgresql16-client bash

WORKDIR /data

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]