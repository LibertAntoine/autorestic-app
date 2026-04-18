FROM alpine:3.20

# Versions
ENV AUTORESTIC_VERSION=v1.8.3

# Install deps
RUN apk add --no-cache \
    bash \
    ca-certificates \
    curl \
    postgresql16-client \
    tzdata

# Install autorestic
RUN curl -L \
    https://github.com/cupcakearmy/autorestic/releases/download/${AUTORESTIC_VERSION}/autorestic_Linux_x86_64.tar.gz \
    | tar -xz -C /usr/local/bin autorestic \
    && chmod +x /usr/local/bin/autorestic

# Working dir
WORKDIR /data

# Optional: autorestic config location
ENV AUTORESTIC_CONFIG=/config/.autorestic.yml

ENTRYPOINT ["autorestic"]