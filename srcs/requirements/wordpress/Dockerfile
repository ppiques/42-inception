FROM	debian:buster

# Updates for apt and installation of wget to be able to download wordpress
RUN		apt update -y && apt upgrade -y
RUN		apt-get -y install wget

# Install PHP and its' dependencies
RUN		apt-get install -y php7.3\
		php-fpm\
		php-mysql\
		mariadb-client

# Install wordpress in /var/www
RUN		wget https://fr.wordpress.org/wordpress-6.1-fr_FR.tar.gz -P /var/www
RUN		cd /var/www && tar -xzf wordpress-6.1-fr_FR.tar.gz && rm wordpress-6.1-fr_FR.tar.gz
RUN		chown -R root:root /var/www/wordpress

# Copy the php configuration
COPY	.conf/php.conf /etc/php/7.3/fpm/pool.d/www.conf


