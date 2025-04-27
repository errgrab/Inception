FROM alpine:3.20

RUN apk update && apk add --no-cache mariadb mariadb-client tini su-exec \
	&& mkdir /run/mysqld && chown mysql:mysql -R /run/mysqld

COPY tools/start.sh /
RUN chmod +x /start.sh

EXPOSE 3306

CMD ["tini","--","/start.sh"]
