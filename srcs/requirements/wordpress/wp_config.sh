#!/bin/sh

# this will make it so every container prints stuff
set -e
set -x

chown -R wordpress /var/www/wordpress
# wait until mariadb is started
mysqladmin --host=mariadb --port=3306 --user="$DB_USER" --password="$DB_PASS" --wait status;

if ! [ -e "/var/www/wordpress/wp-config.php" ]; then
	# Dowloading wordpress files and configuring wordpress
	wp core download --path=/var/www/wordpress --locale=en_US --allow-root
	wp config create --dbname="$DB_NAME" --dbuser="$DB_USER" --dbpass="$DB_PASS" --dbhost=mariadb --path=/var/www/wordpress --allow-root
	wp core install \
		--url="$DOMAIN" --title="$WP_TITLE" \
		--admin_user="$WP_AUSER" --admin_password="$WP_APASS" --admin_email="$WP_AMAIL" --path=/var/www/wordpress --allow-root
	wp user create "$WP_USER" "$WP_MAIL" --user_pass="$WP_PASS" --role=editor --path=/var/www/wordpress --allow-root
	wp option set comment_previously_approved 0 --path=/var/www/wordpress --allow-root

	# the bonus part
	wp config set WP_REDIS_HOST redis --path=/var/www/wordpress --allow-root;
	wp config set WP_REDIS_PORT 6379 --path=/var/www/wordpress --allow-root;
	wp config set WP_REDIS_DATABASE 0 --path=/var/www/wordpress --allow-root;
	wp config set WP_CACHE true --path=/var/www/wordpress --allow-root;
	wp plugin update --all --path=/var/www/wordpress --allow-root;
	wp plugin install redis-cache --activate --path=/var/www/wordpress --allow-root;
	wp redis enable --path=/var/www/wordpress --allow-root;

fi

chown wordpress -R /var/www/
chmod -R +rw /var/www/wordpress/

exec "$@"