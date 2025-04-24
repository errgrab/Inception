FROM alpine:3.20

RUN apk update && apk add --no-cache mariadb mariadb-client tini su-exec \
	&& mkdir /run/mysqld && chown mysql:mysql -R /run/mysqld

COPY tools/start.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/start.sh

EXPOSE 3306

ENTRYPOINT ["tini","--","/usr/local/bin/start.sh"]
CMD ["mysqld"]
