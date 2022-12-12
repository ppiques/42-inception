FROM	debian:buster

RUN		apt-get update && apt-get upgrade -y

RUN		apt-get install nginx -y

RUN		apt-get install openssl -y

RUN		apt-get install curl -y

RUN		apt-get install vim -y

RUN		apt-get install sudo -y

RUN		mkdir -p /etc/nginx/ssl

RUN		mkdir -p /var/run/nginx

COPY	conf/nginx.conf /etc/nginx/nginx.conf

RUN		openssl req -x509 -nodes -out /etc/nginx/ssl/inception.crt -keyout /etc/nginx/ssl/inception.keyout -subj "/C=FR/ST=Ile-de-France/L=Paris/O=42/OU=Stud/CN=ppiques/UID=fake.adress@gmail.com"

RUN		chmod 755 /var/www/html
RUN		chown -R www-data:www-data /var/www/html

# Expose port 443 to allow https:// connections
EXPOSE 443

CMD	[ "nginx", "-g", "daemon off;" ]
