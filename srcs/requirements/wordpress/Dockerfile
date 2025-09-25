FROM    debian:bookworm
# FROM ghcr.io/dockerhub-mirror/debian:bookworm # In case docker hub is down

RUN apt-get update && \
    apt-get install \
        mariadb-client \
        php \
        php-fpm \
        php-mysql \
        wget \
        wordpress -y
RUN groupadd -r wordpress && \
    useradd -r -g wordpress -d /nonexistent -s /usr/sbin/nologin wordpress
RUN wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar -O /bin/wp-cli.phar && \
    chmod +x /bin/wp-cli.phar && \
    ln -s /bin/wp-cli.phar /bin/wp && \
    mkdir -p /var/www/wordpress && \
    rm -rf /var/lib/apt/lists/*

COPY ./www.conf /etc/php/8.2/fpm/pool.d/
COPY ./wp_config.sh /bin/wp_conf
RUN chmod +x /bin/wp_conf

STOPSIGNAL SIGQUIT

CMD ["/bin/wp_conf", "/usr/sbin/php-fpm8.2"]