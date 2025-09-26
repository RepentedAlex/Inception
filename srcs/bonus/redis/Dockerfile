FROM debian:bookworm

RUN apt-get update && \
	apt-get install -y \
		redis-server redis && \
	rm -rf /var/lib/apt/lists/*

COPY ./conf_redis.sh ./bin/conf_redis
RUN chmod +x ./bin/conf_redis

# CMD ["tail", "-f", "/dev/null"]

CMD ["./bin/conf_redis", "redis-server", "--protected-mode", "no"]