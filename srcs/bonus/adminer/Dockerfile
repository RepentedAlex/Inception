FROM	debian:bookworm

RUN	apt-get update && \
	apt-get install -y \
		php \
		php-fpm \
		php-mysql \
		wget && \
	rm -rf /var/lib/apt/lists/*

COPY ./php-fpm.conf /etc/php/8.2/fpm/php-fpm.conf

RUN	wget -L https://github.com/vrana/adminer/releases/download/v4.8.1/adminer-4.8.1.php -O /tmp/adminer.php && \
	mkdir -p /var/www/html && \
	mv /tmp/adminer.php /var/www/html/index.php
	# useradd --system --no-create-home --group www-data www-data

STOPSIGNAL SIGQUIT


CMD ["tail", "-f", "/dev/null"]
# CMD ["/usr/sbin/php-fpm8.2"]