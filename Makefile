.PHONY: up down build clean fclean re

all: up

up:
	mkdir -p /home/ecarvalh/data
	cd srcs && docker-compose up -d --build

down:
	cd srcs && docker-compose down

clean:
	cd srcs && docker-compose down -v

fclean: clean
	cd srcs && docker-compose rm -f
	docker system prune -a

re: clean up
