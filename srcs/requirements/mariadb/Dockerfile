FROM	debian:buster

# Arguments for MySQL from the .env
ARG		MYSQL_DB_NAME
ARG		MYSQL_DB_PASSWORD
ARG		MYSQL_DB_ADMIN
ARG		MYSQL_DB_ADMIN_PASSWORD
ARG		MYSQL_DB_USER
ARG		MYSQL_DB_USER_PASSWORD

# Update and install mariadb
RUN		apt update -y && apt upgrade -y
RUN		apt-get install mariadb-server -y

# Replace conf file with our own
COPY		conf/50-server.cnf /etc/mysql/mariadb.conf.d/50-server.cnf

# Initialization for mariadb
RUN		mysql_install_db --datadir=/var/lib/mysql --user=mysql

# Setup for MYSQL
RUN		service mysql start	&& \
		echo "CREATE DATABASE $MYSQL_DB_NAME;" | mysql -u root && \
		echo "CREATE USER '$MYSQL_DB_ADMIN'@'*';" | mysql -u root && \
		echo "SET password FOR '$MYSQL_DB_ADMIN'@'*' = password('$MYSQL_DB_ADMIN_PASSWORD');" | mysql -u root && \
		echo "CREATE USER '$MYSQL_DB_USER'@'*';" | mysql -u root && \
		echo "SET password FOR '$MYSQL_DB_USER'@'*'; = password('$MYSQL_DB_USER_PASSWORD');" | mysql -u root && \
		echo "GRANT ALL PRIVILEGES ON $MYSQL_DB_NAME.* TO '$MYSQL_DB_ADMIN'@'*' WITH GRANT OPTION;" | mysql -u root && \
		echo "GRANT ALL ON '$MYSQL_DB_NAME'.* to '$MYSQL_DB_ADMIN'@'*' IDENTIFIED BY '$MYSQL_DB_ADMIN_PASSWORD';" && \
		echo "SELECT host FROM mysql.user WHERE user = '$MYSQL_DB_ADMIN';"  | mysql -u root  && \
		echo "CREATE USER '$MYSQL_DB_ADMIN'@'%' IDENTIFIED BY '$MYSQL_DB_ADMIN_PASSWORD';" | mysql -u root && \
		echo "GRANT ALL PRIVILEGES ON *.* TO '$MYSQL_DB_ADMIN'@'%';" | mysql -u root && \
		echo "FLUSH PRIVILEGES;" | mysql -u root # Flush reloads the grant tables without us having to restart the service

# Expose port 3306
EXPOSE		3306

CMD ["mysqld"]
