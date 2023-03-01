FROM	debian:buster

RUN		apt-get update && apt-get upgrade -y
RUN		apt-get install nginx -y
RUN		apt-get install openssl -y
RUN		apt-get install curl -y
RUN		apt-get install vim -y

RUN		mkdir -p /etc/nginx/ssl

COPY	conf/nginx.conf /etc/nginx/nginx.conf
COPY	docker-entrypoint.sh /usr/local/bin

RUN		chmod 755 /var/www/html
RUN		chown -R www-data:www-data /var/www/html

# Expose port 443 to allow https:// connections
EXPOSE 443

ENTRYPOINT [ "/usr/local/bin/docker-entrypoint.sh" ]
CMD	[ "nginx", "-g", "daemon off;" ]
