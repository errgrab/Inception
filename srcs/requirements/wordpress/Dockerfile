FROM alpine:3.20

RUN apk update && apk add --no-cache \
	php83 php83-fpm php83-cli php83-mysqli php83-xml php83-json php83-curl \
	php83-gd php83-zip php83-dom php83-mbstring php83-phar ca-certificates \
	wget bash su-exec tar mariadb-client \
	&& wget -qO /usr/local/bin/wp https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar \
	&& chmod +x /usr/local/bin/wp \
	&& mkdir -p /var/www/html /var/log/php83 \
	&& echo "memory_limit = 512M" >> /etc/php83/php.ini \
	&& sed -i 's|^listen = .*|listen = 0.0.0.0:9000|' /etc/php83/php-fpm.d/www.conf

WORKDIR /var/www/html

COPY tools/start.sh /start.sh
RUN chmod +x /start.sh

EXPOSE 9000

CMD ["/start.sh"]
