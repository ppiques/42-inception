#!/bin/sh

openssl req -x509 -nodes -out /etc/nginx/ssl/inception.crt -keyout /etc/nginx/ssl/inception.keyout -subj "/C=FR/ST=Ile-de-France/L=Paris/O=42/OU=Stud/CN=ppiques/UID=fake.adress@gmail.com"

exec "$@"
