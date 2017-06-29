# Using Wordpress with SSL enabled integrated with NGINX proxy and autorenew LetsEncrypt certificates

This docker-compose should be used with the NGINX Proxy as of sample here:

[https://github.com/evertramos/docker-compose-letsencrypt-nginx-proxy-companion](https://github.com/evertramos/docker-compose-letsencrypt-nginx-proxy-companion)


## Usage

After everything is settle, and you have your three containers running (_proxy, generator and letsencrypt_) you do the following:

1. Clone this repository:

```bash
git clone https://github.com/evertramos/wordpress-docker-letsencrypt.git
```

Or just copy the content of `docker-compose.yml` and the `Dockerfile`, as of below:

```bash
version: '3'

services:
   db:
     container_name: db
     image: mariadb:latest
     restart: unless-stopped
     volumes:
        - /path/to/your/data/db:/var/lib/mysql
     environment:
       MYSQL_ROOT_PASSWORD: root_password
       MYSQL_DATABASE: database_name
       MYSQL_USER: user_name
       MYSQL_PASSWORD: user_password

   wordpress:
     depends_on:
       - db
     container_name: wordpress
     build:
       context: ./
     restart: unless-stopped
     expose:
           - "443"
     volumes:
       - /path/to/your/data/wordpress:/var/www/html
       - /path/to/your/data/wp-content:/var/www/html/wp-content
     environment:
       WORDPRESS_DB_HOST: db:3306
       WORDPRESS_DB_NAME: wordpress
       WORDPRESS_DB_USER: user_name
       WORDPRESS_DB_PASSWORD: user_password
       WORDPRESS_TABLE_PREFIX: wp_
       VIRTUAL_HOST: domain.com, www.domain.com
       VIRTUAL_PROTO: https
       VIRTUAL_PORT: 443
       LETSENCRYPT_HOST: domain.com, www.domain.com
       LETSENCRYPT_EMAIL: your_email@domain.com
```

```bash
# Dockerfile with SSL activated

FROM wordpress

RUN apt-get update && \
    apt-get install -y  --no-install-recommends ssl-cert && \
    rm -r /var/lib/apt/lists/* && \
    a2enmod ssl && \
    a2ensite default-ssl

EXPOSE 80
EXPOSE 443
```

2. Change the file `docker-compose.yml` with you own settings:

2.1. Use a specific network (optional)

In order to use an specific network add the following lines at the end of your file:
```bash
networks:
    default:
       external:
         name: webproxy
```

>Must be the same network used by your nginx services (_proxy, generator and letsencrypt_)

2.2. Change the configuration path where you will locate the nginx files

```bash
    volumes:
      - /CHANGE/HERE/db:/var/lib/mysql

    volumes:
      - /CHANGE/HERE/wordpress:/var/www/html
      - /CHANGE/HERE/wp-content:/var/www/html/wp-content
```

2.3. Set your domain name and email

```bash
       VIRTUAL_HOST: YOUR_DOCMAIN.com, www.YOUR_DOCMAIN.com
       LETSENCRYPT_HOST: YOUR_DOCMAIN.com, www.YOUR_DOCMAIN.com
       LETSENCRYPT_EMAIL: YOUR_EMAIL@YOUR_DOCMAIN.com
```

3. Start your project

```bash
docker-compose up -d
```

**Be patinet** - when you first run a container to get new certificates, it may take a few minuts in order to get everything up and running, my own case, took almos 4 minutes to get LetsEncyrpt settled and proxy ready to go.

Any further information please check:

1. [@JrCs](https://github.com/JrCs/docker-letsencrypt-nginx-proxy-companion).
2. [@jwilder](https://github.com/jwilder/nginx-proxy)
3. [@jwilder](https://github.com/jwilder/docker-gen)

