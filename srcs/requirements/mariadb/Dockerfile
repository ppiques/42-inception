FROM	debian:buster

# Update and install mariadb
RUN		apt update -y && apt upgrade -y
RUN		apt-get install mariadb-server -y

# Replace conf file with our own
COPY		conf/50-server.cnf /etc/mysql/mariadb.conf.d/50-server.cnf

# Copy the bash script in the container for the databse setup
COPY		conf/mariadb-configuration.sh /mariadb-configuration.sh

# Setup for mariadb by executing the bash script
ENTRYPOINT ["bash", "mariadb-configuration.sh"]

# Expose port 3306
EXPOSE		3306
