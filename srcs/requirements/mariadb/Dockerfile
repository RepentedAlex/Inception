FROM    debian:bookworm

# FROM ghcr.io/dockerhub-mirror/debian:bookworm

RUN apt-get update && \
    apt-get install mariadb-server -y && \
    mkdir -p /var/lib/mysql /run/mysqld && \
    chown mysql -R /run/mysqld && \
    rm -rf /var/lib/apt/lists/*

COPY ./maria_conf.sh /bin/maria_conf
RUN chmod +x /bin/maria_conf;

CMD ["/bin/maria_conf", "mysqld"]

# CMD ["tail", "-f", "/dev/null"]