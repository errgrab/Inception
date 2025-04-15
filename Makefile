DOCKER_COMPOSE = srcs/docker-compose.yml

.PHONY: all up down clean fclean re

all: up

up:
	mkdir -p data/wp
	mkdir -p data/db
	docker-compose -f $(DOCKER_COMPOSE) up -d --build



down:
	docker-compose -f $(DOCKER_COMPOSE) down

clean: down
	docker system prune -a

fclean: clean
	docker volume rm $$(docker volume ls -q)
	sudo rm -rf data/wp/*
	sudo rm -rf data/db/*

re: fclean all
