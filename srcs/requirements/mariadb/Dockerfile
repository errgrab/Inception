FROM alpine:3.20

RUN apk update && apk add --no-cache mariadb mariadb-client \
	&& mkdir -p /var/lib/mysql

COPY tools/start.sh /
RUN chmod +x /start.sh

EXPOSE 3306

CMD ["/start.sh"]
