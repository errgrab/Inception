setup:
	cd srcs/requirements/nginx/tools && ./generate_ssl.sh
build:
	cd srcs && docker-compose build
up:
	cd srcs && docker-compose up
down:
	cd srcs && docker-compose down
restart: down build up
