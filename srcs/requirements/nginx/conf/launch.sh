#!/bin/sh

set -e	
set -x	

chown -R www-data:www-data /var/www/html

if [ ! -f /etc/nginx/ssl/certs/nginx.crt ]; then
	echo "Generating SSL certificate..."
	openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
		-keyout /etc/nginx/ssl/private/nginx.key \
		-out /etc/nginx/ssl/certs/nginx.crt \
		-subj "/C=FR/STD=IDF/L=Paris/O=42/CN=${DOMAIN}"
fi

sed -i /etc/nginx/nginx.conf -e 's/#SERVER_NAME_HERE#/server_name '"$DOMAIN www.$DOMAIN"/;
NAMESERVER="$(awk '/^nameserver/{print $2}' /etc/resolv.conf)"

sed -i /etc/nginx/nginx.conf -e 's/#RESOLVER_HERE#/resolver '"$NAMESERVER"'/'

exec "nginx" "-g" "daemon off;"	# `exec` command is used to run its argument as PID 1.
