FROM ghcr.io/hotio/prowlarr:latest

# Build args to bust cache when dependencies change
ARG GIST_HASH=unknown

RUN apk update && \
    apk add --no-cache --no-scripts git && \
    rm -rf /var/cache/apk/*

# Download YGG-API indexer
RUN echo "Fetching YGG-API gist hash: ${GIST_HASH}" && \
    mkdir -p /Clemv95 && \
    git clone https://gist.github.com/8bfded23ef23ec78f6678896f42a2b60.git /Clemv95/ygg-api && \
    mkdir -p /app/indexer-definitions && \
    cp /Clemv95/ygg-api/ygg-api-download.yml /app/indexer-definitions/ && \
    rm -rf /Clemv95

# Download ygege indexer
RUN git clone https://github.com/UwUDev/ygege.git /tmp/ygege && \
    cp /tmp/ygege/ygege.yml /app/indexer-definitions/ && \
    rm -rf /tmp/ygege

# Copy init script and make it executable
COPY init-indexers.sh /app/init-indexers.sh
RUN chmod +x /app/init-indexers.sh && \
    chown hotio:hotio /app/init-indexers.sh

VOLUME /config
EXPOSE 9696

# Use custom entrypoint that copies indexer to mounted volume
ENTRYPOINT ["/app/init-indexers.sh"]
