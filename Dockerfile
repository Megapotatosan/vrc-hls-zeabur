FROM debian:bookworm-slim

RUN apt-get update && apt-get install -y --no-install-recommends \
    nginx \
    libnginx-mod-rtmp \
    gettext-base \
    ca-certificates \
    && rm -rf /var/lib/apt/lists/*

COPY nginx.conf.template /etc/nginx/nginx.conf.template

RUN mkdir -p /tmp/hls /var/lib/nginx /var/log/nginx

ENV PORT=8080
ENV RTMP_PORT=1935

EXPOSE 8080
EXPOSE 1935

CMD ["sh", "-c", "envsubst '$PORT $RTMP_PORT' < /etc/nginx/nginx.conf.template > /etc/nginx/nginx.conf && nginx -g 'daemon off;'"]
