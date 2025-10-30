DATA_DIR	=	~/data

all:
	$(MAKE) --no-print-directory build
	$(MAKE) --no-print-directory up

build: .env
	bash -c "mkdir -p $(DATA_DIR)/{wordpress,mariadb,certs}"
	docker compose -f ./srcs/docker-compose.yml build

up:
	docker compose -f ./srcs/docker-compose.yml up -d

stop:
	docker compose -f ./srcs/docker-compose.yml stop

clean:
	docker compose -f ./srcs/docker-compose.yml down
	sudo rm -rf $(DATA_DIR)

prune:
	docker compose -f ./srcs/docker-compose.yml down
	docker system prune -f -a
	docker image prune -f -a
	docker volume prune -f

re: stop clean all

.PHONY: build up stop clean prune re

export DATA_DIR
