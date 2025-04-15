FROM alpine:3.20

RUN apk update && apk add --no-cache \
	php php-fpm php-mysqli php-json php-curl php-dom php-exif php-fileinfo \
	php-mbstring php-openssl php-xml php-zip php-phar wget curl \
	mariadb-client mysql-client

RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar && \
	chmod +x wp-cli.phar && mv wp-cli.phar /usr/local/bin/wp

RUN mkdir -p /run/php && \
	sed -i 's/listen = 127.0.0.1:9000/listen = 9000/g' /etc/php83/php-fpm.d/www.conf

WORKDIR /var/www/html

COPY ./tools/wordpress_setup.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/wordpress_setup.sh

EXPOSE 9000

CMD ["/usr/local/bin/wordpress_setup.sh"]
