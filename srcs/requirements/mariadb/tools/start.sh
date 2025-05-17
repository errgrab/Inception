#!/bin/sh
set -e

#	su-exec mysql mariadb-install-db --user=mysql --datadir=/var/lib/mysql
#	su-exec mysql mysqld --user=mysql --datadir=/var/lib/mysql --skip-networking &

if [ ! -d "/var/lib/mysql/mysql" ]; then
	echo "Initialising MariaDB"

	DB_ROOT_PASS=$(cat /run/secrets/dbrootpass)
	WP_DB_PASS=$(cat /run/secrets/dbpass)

	mariadbd --initialize-insecure --datadir=/var/lib/mysql
	mariadbd --datadir=/var/lib/mysql --skip-networking --socket=/tmp/mysql.sock &
	pid="$!"
	
	until mysqladmin ping --socket=/tmp/mysql.sock --silent; do
		sleep 1
	done

	mysql -u root --socket=/tmp/mysql.sock <<-EOSQL

ALTER USER 'root'@'localhost' IDENTIFIED BY '$DB_ROOT_PASS';
CREATE DATABASE IF NOT EXISTS \`$WP_DB_NAME\`;
CREATE USER IF NOT EXISTS '$WP_DB_USER'@'%' IDENTIFIED BY '$WP_DB_PASS';
GRANT ALL PRIVILEGES ON \`$WP_DB_NAME\`.* TO '$WP_DB_USER'@'%';
FLUSH PRIVILEGES;

EOSQL

	kill "$pid"
fi

#exec su-exec mysql mariadbd
exec mariadbd --datadir=/var/lib/mysql --bind-address=0.0.0.0
