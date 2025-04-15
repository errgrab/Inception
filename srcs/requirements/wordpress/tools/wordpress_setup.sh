#!/bin/sh

until mysql -h mariadb -u ${MYSQL_USER} -p${MYSQL_PASSWORD} -e "SELECT 1"; do
	echo "Waiting for MariaDB to be ready..."
	sleep 5
done

if [ ! -f wp-config.php ]; then
	wp core download --allow-root

	wp config create --allow-root \
		--dbname=${MYSQL_DATABASE} --dbuser=${MYSQL_USER} \
		--dbpass=${MYSQL_PASSWORD} --dbhost=mariadb --path=/var/www/html

	wp core install --allow-root ${WP_USER} ${WP_USER_EMAIL} \
		--user_pass=${WP_USER_PASSWORD} --role=author
fi

exec php-fpm81 -F
