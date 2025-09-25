FROM    debian:bookworm

# FROM ghcr.io/dockerhub-mirror/debian:bookworm

RUN apt-get update && \
    apt-get install -y nginx openssl && \
    mkdir -p /etc/nginx/ssl/private /etc/nginx/ssl/certs && \
    openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
        -keyout /etc/nginx/ssl/private/nginx.key \
        -out /etc/nginx/ssl/certs/nginx.crt \
        -subj "/C=FR/ST=IDF/L=Paris/O=42/OU=42/CN=apetitco.42.fr/UID=apetitco" && \
    chmod 755 /var/www && \
    chown -R www-data:www-data /var/www
RUN rm -rf /var/lib/apt/lists/*

COPY ./conf/nginx.conf /etc/nginx/nginx.conf
COPY ./conf/launch.sh /bin/nginx-launch
RUN	chmod +x /bin/nginx-launch

EXPOSE 443/tcp

CMD ["/bin/nginx-launch", "nginx"]

# CMD ["nginx", "-g", "daemon off;"]