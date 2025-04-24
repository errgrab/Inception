#!/bin/sh
set -e

DB_ROOT_PASS=$(</run/secrets/dbrootpass)

chown -R mysql:mysql /run/mysqld /var/lib/mysql

if [ ! -d "/var/lib/mysql/mysql" ]; then
	echo "→  Initialising fresh MariaDB data dir"
	su-exec mysql mariadb-install-db --user=mysql --datadir=/var/lib/mysql
fi

exec su-exec mysql mysqld "$@"
