FROM alpine:3.21

LABEL maintainer="apetitco@student.42.fr"
LABEL description="Nginx with TLS 1.2/1.3 for 42 Inception project."
LABEL version="1.1"

# Packages installation
RUN apk add --no-cache \
      nginx \
      openssl \
      curl

RUN mkdir -p /etc/nginx/ssl/private /etc/nginx/ssl/certs

COPY ./conf/nginx.conf /etc/nginx/nginx.conf
COPY ./conf/entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

EXPOSE 443

HEALTHCHECK --interval=30s --timeout=5s --start-period=10s --retries=3 \
  CMD	curl -fk https://localhost:443/ || exit 1

ENTRYPOINT ["/entrypoint.sh"]
CMD ["nginx", "-g", "daemon off;"]
