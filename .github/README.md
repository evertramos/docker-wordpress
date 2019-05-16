# Using Wordpress with SSL enabled integrated with NGINX proxy and autorenew LetsEncrypt certificates

![wordpress-docker-letsencrypt](https://github.com/evertramos/images/raw/master/wordpress.jpg)

This docker-compose should be used with WebProxy (the NGINX Proxy):

[https://github.com/evertramos/docker-compose-letsencrypt-nginx-proxy-companion](https://github.com/evertramos/docker-compose-letsencrypt-nginx-proxy-companion)


## Usage

After everything is settle, and you have your three containers running (_proxy, generator and letsencrypt_) you do the following:

1. Clone this repository:

```bash
git clone https://github.com/evertramos/docker-wordpress-letsencrypt.git
```

Or just copy the content of `docker-compose.yml` and the `.env` file, as of below:

```bash
version: '3'

services:
   db:
     container_name: ${CONTAINER_DB_NAME}
     image: mariadb:latest
     restart: unless-stopped
     volumes:
        - ${DB_PATH}:/var/lib/mysql
     environment:
       MYSQL_ROOT_PASSWORD: ${MYSQL_ROOT_PASSWORD}
       MYSQL_DATABASE: ${MYSQL_DATABASE}
       MYSQL_USER: ${MYSQL_USER}
       MYSQL_PASSWORD: ${MYSQL_PASSWORD}

   wordpress:
     depends_on:
       - db
     container_name: ${CONTAINER_WP_NAME}
     image: wordpress:latest
     restart: unless-stopped
     volumes:
       - ${WP_CORE}:/var/www/html
       - ${WP_CONTENT}:/var/www/html/wp-content
     environment:
       WORDPRESS_DB_HOST: ${CONTAINER_DB_NAME}:3306
       WORDPRESS_DB_NAME: ${MYSQL_DATABASE}
       WORDPRESS_DB_USER: ${MYSQL_USER}
       WORDPRESS_DB_PASSWORD: ${MYSQL_PASSWORD}
       WORDPRESS_TABLE_PREFIX: ${WORDPRESS_TABLE_PREFIX}
       VIRTUAL_HOST: ${DOMAINS}
       LETSENCRYPT_HOST: ${DOMAINS}
       LETSENCRYPT_EMAIL: ${LETSENCRYPT_EMAIL} 

#   wpcli:
#     image: tatemz/wp-cli
#     volumes:
#       - ${WP_CORE}:/var/www/html
#       - ${WP_CONTENT}:/var/www/html/wp-content
#     depends_on:
#       - db
#     entrypoint: wp

networks:
    default:
       external:
         name: ${NETWORK}
```

> **[IMPORTANT]** Make sure to update your **services** name for each application so it does not conflicts with another service, such as, in the _docker_compose.yml_ where we have **db** you could use **site1-db**, and **wordpress** you could use **site1-wordpress**. Update this to site2 when you put up a new site.

2. Make a copy of our .env.sample and rename it to .env:

Update this file with your preferences.

```bash
# .env file to set up your wordpress site

#
# Network name
# 
# Your container app must use a network conencted to your webproxy 
# https://github.com/evertramos/docker-compose-letsencrypt-nginx-proxy-companion
#
NETWORK=webproxy

#
# Database Container configuration
# We recommend MySQL or MariaDB - please update docker-compose file if needed.
#
CONTAINER_DB_NAME=db

# Path to store your database
DB_PATH=/path/to/your/local/database/folder

# Root password for your database
MYSQL_ROOT_PASSWORD=root_password

# Database name, user and password for your wordpress
MYSQL_DATABASE=database_name
MYSQL_USER=user_name
MYSQL_PASSWORD=user_password

#
# Wordpress Container configuration
#
CONTAINER_WP_NAME=wordpress

# Path to store your wordpress files
WP_CORE=/path/to/your/wordpress/core/files
WP_CONTENT=/path/to/your/wordpress/wp-content

# Table prefix
WORDPRESS_TABLE_PREFIX=wp_

# Your domain (or domains)
DOMAINS=domain.com,www.domain.com

# Your email for Let's Encrypt register
LETSENCRYPT_EMAIL=your_email@domain.com
```

>This container must use a network connected to your webproxy or the same network of your webproxy.

3. Start your project

```bash
docker-compose up -d
```

**Be patient** - when you first run a container to get new certificates, it may take a few minutes.

----

### Make sure the wordpress data files has user and group set to **www-data**, so you could update, install, delete files from your admin panel.

----


## WebProxy

[WebProxy - docker-compose-letsencrypt-nginx-proxy-companion](https://github.com/evertramos/docker-compose-letsencrypt-nginx-proxy-companion)

----

# Further Options

## wp-cli (https://wp-cli.org/)

For whoever uses *wp-cli* here is how to implement it on this repo. 


i. Take down your services

```bash
docker-compose down 
```

ii. Uncomment the following lines on _docker-compose.yml_:

```bash
#   wpcli:
#     image: tatemz/wp-cli
#     volumes:
#       - ${WP_CORE}:/var/www/html
#       - ${WP_CONTENT}:/var/www/html/wp-content
#     depends_on:
#       - db
#     entrypoint: wp
```

iii. Start your services again

```bash
docker-compose up -d
```

iv. Test to see if it´s working

```bash
./wp-cli-test.sh

```

If you would, add the alias "wp" to your `.bash_aliases`:

```bash
alias wp="docker-compose run --rm wpcli"
```

Next time you need to run a wp-cli command just go to where you have your docker-compose file and run a `wp` command.

----

## Backup Option

We developed a backup option for this set up which you can find more details here:

[Docker Wordpress Backup](https://github.com/evertramos/docker-wordpress-backup)


## Issues

Please be advised that if are running docker on azure servers you must mount your database in your disks partitions (example: `/mnt/data/`) so your db container can work. This is a some kind of issue regarding Hyper-V sharing drivers... not really sure why.


## Full Source

1. [@jwilder](https://github.com/jwilder/nginx-proxy)
2. [@jwilder](https://github.com/jwilder/docker-gen)
3. [@JrCs](https://github.com/JrCs/docker-letsencrypt-nginx-proxy-companion).
