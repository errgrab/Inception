FROM alpine:3.20

RUN apk update && apk add --no-cache mariadb mariadb-client && \
	mkdir -p /run/mysqld && \
	chown -R mysql:mysql /run/mysqld && \
	mkdir -p /var/lib/mysql && \
	chown -R mysql:mysql /var/lib/mysql

COPY ./conf/my.cnf /etc/my.cnf.d/mariadb-server.cnf

COPY ./tools/mariadb_setup.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/mariadb_setup.sh

EXPOSE 3306

CMD ["/usr/local/bin/mariadb_setup.sh"]
