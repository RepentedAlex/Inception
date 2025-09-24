- [ ] Container NGINX avec TLSv1.2/TLSv1.3
- [ ] Container Wordpress avec php-fpm
- [ ] Container MariaDB
- [ ] Un volume qui contient la base de donnée du Wordpress
- [ ] Un volume qui contient les fichiers du site Wordpress
- [ ] Un docker-network qui établit les connexions entre les containers
- [ ] Docker networking, using custom networks (NO `links`)


# Commands
docker build (ex: docker build -t <nom container> -f \<dockerfile\> \<contexte\>):
    Cette commande wrap `Buildx` qui est un outil CLI pour lancer les builds,
`Buildx` transmet ensuite la requête au `BuildKit`. Le but de `docker build` est
de créer une image d'un container.

docker ps : List the running containers
docker compose up :
docker compose down :
docker inspect :
docker exec : Run a command in a running container
docker start : Starts a container (often used after `docker stop`)
docker stop : Stop a container
docker run : Run a command in a new container
docker rm : Remove one or more containers
docker rmi : Remove one or more images
docker image : Lists the images
