#!/bin/sh

DB_ROOT_PASS=$(cat /run/secrets/dbrootpass)

mkdir -p /run/mysqld
chown -R mysql:mysql /run/mysqld

if [ ! -d "/var/lib/mysql/mysql" ]; then
	mysql_install_db --user=mysql --basedir=/usr --datadir=/var/lib/mysql
fi

mkdir -p /docker-entrypoint-initdb.d/

cat << EOF > /docker-entrypoint-initdb.d/init.sql
CREATE DATABASE IF NOT EXISTS \`$WP_DB_NAME\`;
CREATE USER IF NOT EXISTS 'root'@'%' IDENTIFIED BY '$DB_ROOT_PASS';
GRANT ALL PRIVILEGES ON *.* TO 'root'@'%' WITH GRAN OPTION;
FLUSH PRIVILEGES;
EOF

chown -R mysql:mysql /var/lib/mysql

exec su-exec mysql mysqld
