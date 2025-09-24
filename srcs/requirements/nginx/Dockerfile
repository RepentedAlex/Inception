FROM debian:bookworm

RUN apt-get update && apt-get install -y nginx openssl

RUN mkdir -p /etc/nginx/ssl && \
    openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout /etc/nginx/ssl/nginx.key -out /etc/nginx/ssl/nginx.crt -subj "/C=FR/ST=IDF/L=Paris/O=42/OU=42/CN=apetitco.42.fr/UID=apetitco"

COPY ./conf/nginx.conf /etc/nginx/nginx.conf

EXPOSE 443/tcp

CMD ["nginx", "-g", "daemon off;"]