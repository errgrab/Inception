CREATE DATABASE IF NOT EXISTS wordpress_db;
CREATE USER 'wordpress_user'@'%' IDENTIFIED BY '${MYSQL_PASSWORD}';
GRANT ALL PRIVILEGES ON wordpress_db.* TO 'wordpress_user'@'%';
FLUSH PRIVILEGES;
