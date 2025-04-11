FROM alpine:3.20
RUN apk update && apk add mariadb mariadb-client
COPY ./conf/my.cnf /etc/my.cnf.d/
COPY ./tools/init.sql /docker-entrypoint-initdb.d/
RUN chmod 755 /docker-entrypoint-initdb.d/init.sql
EXPOSE 3306
CMD ["mysqld", "--user=mysql"]
