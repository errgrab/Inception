#!/bin/bash
set -e

WP_ADMIN_PASS=$(cat /run/secrets/wp_admin_pass)
WP_DB_PASS=$(cat /run/secrets/db_pass)

echo "Waiting for MariaDB to be ready..."
until mysqladmin ping -h"$WP_DB_HOST" --silent; do
	sleep 1
done
echo "MariaDB is ready."

if [ ! -f wp-config.php ]; then
	echo "Downloading WordPress..."
	wp core download --allow-root

	echo "Creating wp-config.php..."
	wp config create --allow-root \
		--dbname="$WP_DB_NAME" --dbuser="$WP_DB_USER" \
		--dbpass="$WP_DB_PASS" --dbhost="$WP_DB_HOST" \
		--skip-check

	echo "Installing WordPress..."
	wp core install --allow-root \
		--url="https://$DOMAIN_NAME" \
		--title="$WP_TITLE" --admin-user="$WP_ADMIN_USER" \
		--admin_password="$WP_ADMIN_PASS" \
		--admin_email="$WP_ADMIN_EMAIL"
fi

chown -R www-data:www-data /var/www/html

exec php-fpm82 --nodaemonize
