#!/bin/sh

set -e	
set -x	

if [ ! -f /etc/nginx/ssl/certs/nginx.crt ]; then
  echo "Generating SSL certificate..."
  openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
    -keyout /etc/nginx/ssl/private/nginx.key \
    -out /etc/nginx/ssl/certs/nginx.crt \
    -subj "/C=FR/ST=IDF/L=Paris/O=42/CN=${DOMAIN}"
fi

chown -R nginx:nginx /var/www/html
sed -i "s/#SERVER_NAME_HERE#/${DOMAIN} www.${DOMAIN}/" /etc/nginx/nginx.conf

echo "Testing nginx configuration file..."
nginx -t

echo "Starting nginx..."
exec "$@"
