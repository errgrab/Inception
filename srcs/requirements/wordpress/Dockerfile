FROM alpine:3.20
RUN apk update && apk add php-fpm php-mysqli php-json
COPY ./tools/configure_wp.sh /
RUN chmod +x /configure_wp.sh
WORKDIR /var/www/html
CMD ["/configure_wp.sh"]
