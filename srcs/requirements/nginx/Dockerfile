FROM	alpine:3.15.6

RUN		apk update && apk upgrade && apk add \
			openssl \
			nginx \
			curl \
			vim \
			sudo

RUN		mkdir -p /etc/nginx/ssl

RUN		mkdir -p /var/run/nginx

COPY	conf/nginx.conf /etc/nginx/nginx.conf

RUN		openssl req -x509 -nodes -out /etc/nginx/ssl/inception.crt -keyout /etc/nginx/ssl/inception.keyout -subj "/C=FR/ST=Ile-de-France/L=Paris/O=42/OU=Stud/CN=ppiques/UID=fake.adress@gmail.com"

RUN		chmod 755 /var/www/html
RUN		chown -R www-data:www-data /var/www/html

# Expose port 443 to allow https:// connections
EXPOSE 443

CMD	[ "nginx", "-g", "daemon off;" ]
