#!/bin/sh

#MYSQL_DB_NAME=database1;
#MYSQL_DB_USER=user1;
#MYSQL_DB_USER_PASSWORD=pass1;
#MYSQL_ROOT_PASSWORD=pass2;

mkdir -p /run/mysqld
chown mysql /run/mysqld
mysql_install_db --user=mysql \
   --basedir=/usr \
   --datadir=/var/lib/mysql

mysqld &
sleep 5; # Give MySQL a few seconds to start before executing the commands
mysql -p$MYSQL_ROOT_PASSWORD <<eof
CREATE DATABASE IF NOT EXISTS \`${MYSQL_DB_NAME}\`; # Create table
CREATE USER IF NOT EXISTS \`${MYSQL_DB_USER}\`@'localhost' IDENTIFIED BY '${MYSQL_DB_USER_PASSWORD}'; # Create user
GRANT ALL PRIVILEGES ON \`${MYSQL_DB_NAME}\`.* TO \`${MYSQL_DB_USER}\`@'%' IDENTIFIED BY '${MYSQL_DB_USER_PASSWORD}' WITH GRANT OPTION; # Give privileges to admin user
ALTER USER 'root'@'localhost' IDENTIFIED BY '${MYSQL_ROOT_PASSWORD}'; # Update root user
SHOW DATABASES;
FLUSH PRIVILEGES; # Flush reloads the grants table 
eof
mysqladmin -u root -p$MYSQL_ROOT_PASSWORD shutdown # Shutdown MySQL
exec mysqld_safe # Start MySQL
