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

if [ ! -d /var/lib/mysql/$MYSQL_DB_NAME ] ; then
	echo "Creating the $MYSQL_DB_NAME database..."
	cat << EOF > /tmp/tmpfile.sql
USE mysql;
FLUSH PRIVILEGES ;
GRANT ALL ON *.* TO 'root'@'%' identified by '$MYSQL_ROOT_PASSWORD' WITH GRANT OPTION ;
GRANT ALL ON *.* TO 'root'@'localhost' identified by '$MYSQL_ROOT_PASSWORD' WITH GRANT OPTION ;
SET PASSWORD FOR 'root'@'localhost'=PASSWORD('${MYSQL_ROOT_PASSWORD}') ;
DROP DATABASE IF EXISTS test ;
FLUSH PRIVILEGES ;
CREATE DATABASE IF NOT EXISTS \`$MYSQL_DB_NAME\` CHARACTER SET utf8 COLLATE utf8_general_ci;
GRANT ALL ON \`$MYSQL_DB_NAME\`.* to '$MYSQL_DB_USER'@'%' IDENTIFIED BY '$MYSQL_DB_USER_PASSWORD';
EOF

	mysqld --user=mysql --bootstrap --verbose=0 --skip-name-resolve \
				--skip-networking=0 < /tmp/tmpfile.sql
	rm -f /tmp/tmpfile.sql
fi



#mysqladmin -u root -p$MYSQL_ROOT_PASSWORD shutdown # Shutdown MySQL
exec mysqld_safe # Start MySQL
