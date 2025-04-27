#!/bin/sh
set -e

DB_ROOT_PASS=$(cat /run/secrets/dbrootpass)
WP_DB_PASS=$(cat /run/secrets/dbpass)

echo root pass: $DB_ROOT_PASS db pass: $WP_DB_PASS

chown -R mysql:mysql /run/mysqld /var/lib/mysql

if [ ! -d "/var/lib/mysql/mysql" ]; then
	echo "Initialising fresh MariaDB"

	su-exec mysql mariadb-install-db --user=mysql --datadir=/var/lib/mysql

	su-exec mysql mysqld --user=mysql --datadir=/var/lib/mysql --skip-networking &
	pid="$!"
	sleep 5

	mysql -u root <<-EOSQL
		ALTER USER 'root'@'localhost' IDENTIFIED BY '$DB_ROOT_PASS';
		CREATE DATABASE IF NOT EXISTS \`$WP_DB_NAME\`;
		CREATE USER IF NOT EXISTS '$WP_DB_USER'@'%' IDENTIFIED BY '$WP_DB_PASS';
		GRANT ALL PRIVILEGES ON \`$WP_DB_NAME\`.* TO '$WP_DB_USER'@'%';
		FLUSH PRIVILEGES;
EOSQL

	kill "$pid"
	wait "$pid"
fi

echo "bind-address=0.0.0.0" > /etc/my.cnf.d/mariadb-server.cnf

exec su-exec mysql mysqld
