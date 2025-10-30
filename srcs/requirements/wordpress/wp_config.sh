#!/bin/sh

# this will make it so every container prints stuff
set -e
set -x

chown -R wordpress /var/www/html
# wait until mariadb is started
mysqladmin --host=mariadb --port=3306 --user="$DB_USER" --password="$DB_PASS" --wait status;

if ! [ -e "/var/www/html/wp-config.php" ]; then
  # Dowloading wordpress files and configuring wordpress
  wp core download --path=/var/www/html --locale=en_US --allow-root
  wp config create --dbname="$DB_NAME" --dbuser="$DB_USER" --dbpass="$DB_PASS" --dbhost=mariadb --path=/var/www/html --allow-root
  wp core install \
    --url="$DOMAIN" --title="$WP_TITLE" \
    --admin_user="$WP_ADMIN" --admin_password="$WP_APASS" --admin_email="$WP_AMAIL" --path=/var/www/html --allow-root
  wp user create "$WP_USER" "$WP_MAIL" --user_pass="$WP_PASS" --role=editor --path=/var/www/html --allow-root
  wp option set comment_previously_approved 0 --path=/var/www/html --allow-root
fi

chown wordpress -R /var/www/html
chmod -R +rw /var/www/html/

exec "$@"
