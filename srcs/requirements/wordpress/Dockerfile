FROM alpine:3.20

RUN apk update && apk add --no-cache php82 php82-fpm mariadb-client fcgi \
	php82-cgi curl tar bash su-exec shadow

RUN mkdir -p /run/php /var/www/html

RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar && \
	chmod +x wp-cli.phar && mv wp-cli.phar /usr/local/bin/wp

WORKDIR /var/www/html

COPY tools/start.sh /usr/local/bin/start.sh
RUN chmod +x /usr/local/bin/start.sh

EXPOSE 9000

CMD ["/usr/local/bin/start.sh"]
