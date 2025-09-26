#!/bin/sh

set -e
set -x

if [ ! -f "/etc/redis/redis.conf.bak" ]; then

	cp /etc/redis/redis.conf /etc/redis/redis.conf.bak

	# listen on all ip. not just localhost
	sed -i "s/bind 127.0.0.1/bind 0.0.0.0/g" /etc/redis/redis.conf
	
	# configure max memory used by redis store
	sed -i "s/# maxmemory <bytes>/maxmemory 2mb/g" /etc/redis/redis.conf
	
	# configure eviction strategy
	sed -i "s/# maxmemory-policy noeviction/maxmemory-policy allkeys-lru/g" /etc/redis/redis.conf

fi

exec "$@"