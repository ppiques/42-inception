#!/bin/sh

MYSQL_DB_NAME=database1;
MYSQL_DB_USER=user1;
MYSQL_DB_USER_PASSWORD=pass1;
MYSQL_ROOT_PASSWORD=pass2;

service mysql start;
sleep 2; # Give MySQL a few seconds to start before executing the commands
mysql -e "CREATE DATABASE IF NOT EXISTS \`${MYSQL_DB_NAME}\`;" # Create table
mysql -e "CREATE USER IF NOT EXISTS \`${MYSQL_DB_USER}\`@'localhost' IDENTIFIED BY '${MYSQL_DB_USER_PASSWORD}';" # Create user
mysql -e "GRANT ALL PRIVILEGES ON \`${MYSQL_DB_NAME}\`.* TO \`${MYSQL_DB_USER}\`@'%' IDENTIFIED BY '${MYSQL_DB_USER_PASSWORD}' WITH GRANT OPTION;" # Give privileges to admin user
mysql -e "ALTER USER 'root'@'localhost' IDENTIFIED BY '${MYSQL_ROOT_PASSWORD}';" # Update root user
mysql -p"${MYSQL_ROOT_PASSWORD}" -e "SHOW DATABASES;"
mysql -p"${MYSQL_ROOT_PASSWORD}" -e "FLUSH PRIVILEGES;" # Flush reloads the grants table 
mysqladmin -u root -p$MYSQL_ROOT_PASSWORD shutdown # Shutdown MySQL
exec mysqld_safe # Start MySQL
