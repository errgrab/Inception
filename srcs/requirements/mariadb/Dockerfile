FROM alpine:3.20

RUN apk update && apk add --no-cache mariadb mariadb-openrc su-exec

COPY ./tools/start.sh /start.sh
RUN chmod +x /start.sh

VOLUME /var/lib/mysql

EXPOSE 3306

CMD ["/start.sh"]
