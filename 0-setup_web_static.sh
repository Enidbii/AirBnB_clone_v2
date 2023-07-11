#!/usr/bin/env bash

c_exists(){
	command -v "$1" > /dev/null 2>&1;
}

if ! c_exists nginx; then
	sudo apt-get update
	sudo apt-get install nginx -y
fi 

mkdir -p /data/web_static/shared/
mkdir -p /data/web_static/releases/test/
echo  -e "This is simple content to test your Nginx configuration" | sudo tee /data/web_static/releases/test/index.html

ln -sf /data/web_static/releases/test /data/web_static/current
sudo chown -R  ubuntu:ubuntu /data/

printf %s "server {
    listen 80 default_server;
    listen [::]:80 default_server;
    add_header X-Served-By $HOSTNAME;
    root   /var/www/html;
    index  index.html index.htm;

    location /hbnb_static {
        alias /data/web_static/current;
        index index.html index.htm;
    }

    location /redirect_me {
        return 301 http://collotek.tech.com/;
    }

    error_page 404 /404.html;
    location /404 {
      root /var/www/html;
      internal;
    }
}" > /etc/nginx/sites-available/default

service nginx restart


