FROM alpine:3.20

RUN apk update && apk add --no-cache php83 php83-fpm php83-mysqli php83-xml \
	php83-json php83-curl php83-gd php83-zip wget ca-certificates tar \
	&& mkdir -p /var/www/html \
	&& wget -qO- https://wordpress.org/latest.tar.gz | tar -xz --strip-components=1 -C /var/www/html \
	&& sed -i 's|^listen = .*|listen = 0.0.0.0:9000|' /etc/php83/php-fpm.d/www.conf \
	&& mkdir -p /var/log/php83 && chown nobody:nobody /var/log/php83 \
	&& chmod 755 /var/log /var/log/php83 \
	&& chown -R nobody:nobody /var/www/html

WORKDIR /var/www/html

EXPOSE 9000

USER nobody
CMD ["php-fpm83", "-F"]
