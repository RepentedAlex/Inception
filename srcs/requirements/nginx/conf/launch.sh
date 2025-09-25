#!/bin/sh

set -e
set -x

chown -R www-data:www-data /var/www/html
sed -i /etc/nginx/nginx.conf -e 's/#SERVER_NAME_HERE#/server_name '"$DOMAIN www.$DOMAIN"/;
NAMESERVER="$(awk '/^nameserver/{print $2}' /etc/resolv.conf)"
sed -i /etc/nginx/nginx.conf -e 's/#RESOLVER_HERE#/resolver '"$NAMESERVER"'/'

exec "nginx" "-g" "daemon off;"