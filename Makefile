up:
	
	docker-compose up --build -d

down:
	docker-compose down

clean:
	docker system prune -a

rebuild:
	docker-compose down
	docker-compose up --build -d

.PHONY: up down clean rebuild