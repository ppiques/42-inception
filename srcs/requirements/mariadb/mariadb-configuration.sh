service mysql start;
mysql -e "CREATE DATABSE IF NOT EXISTS \`${MYSQL_DB_NAME}\`;" # Create table
mysql -e "CREATE USER IF NOT EXISTS \`${MYSQL_DB_ADMIN}\`@'localhost' IDENTIFIED BY '${MYSQL_DB_ADMIN_PASSWORD}';" # Create admin user
mysql -e "CREATE USER IF NOT EXISTS \`${MYSQL_DB_USER}\`@'localhost' IDENTIFIED BY '${MYSQL_DB_USER_PASSWORD}';" # Create user
mysql -e "GRANT ALL PRIVILEGES ON \`${MYSQL_DB_NAME}\`.* TO \`${MYSQL_DB_ADMIN}\`@'%' IDENTIFIED BY '${MYSQL_DB_ADMIN_PASSWORD}';" # Give privileges to admin user
mysql -e "ALTER USER 'root'@'localhost' IDENTIFIED BY '${MYSQL_ROOT_PASSWORD}';" # Update root user
mysql -e "FLUSH PRIVILEGES;" # Flush reloads the grants table 
mysqladmin -u root -p$MYSQL_ROOT_PASSWORD shutdown # Shutdown MySQL
exec mysqld_safe # Start MySQL
