FROM alpine:3.20

RUN apk update && apk add --no-cache mariadb mariadb-client su-exec \
	&& mkdir -p /var/lib/mysql /var/run/mysqld \
	&& chown -R mysql:mysql /var/lib/mysql /var/run/mysqld \
	&& sed -i 's/^skip-networking/bind-address=0.0.0.0/' \
		/etc/my.cnf.d/mariadb-server.cnf

COPY tools/start.sh /start.sh
RUN chmod +x /start.sh

EXPOSE 3306

CMD ["/start.sh"]
