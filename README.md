# Docker Wordpress 🚀

<p align="center">
    <a target="_blank" href="https://docs.docker.com/"><img src="https://img.shields.io/badge/Docker-2CA5E0?style=for-the-badge&logo=docker&logoColor=white" /></a>
    <a target="_blank" href="https://developer.wordpress.org/"><img src="https://img.shields.io/badge/Wordpress-21759B?style=for-the-badge&logo=wordpress&logoColor=white" /></a>
</p>

![wordpress-docker-letsencrypt](https://github.com/evertramos/images/raw/master/wordpress.jpg)


## How to start 🔰

This script was designed to work along with [**Server Automation**](https://github.com/evertramos/server-automation),
where you will be able to start a new WordPress site in less than a minute. 
You may use directly with your [NGINX Proxy Automation](https://github.com/evertramos/nginx-proxy-automation) 
following the [previous docs](./docs/v0.5.md). 

## Known Issues 💭 

### 1. Azure

Running docker on Azure servers you must mount your database in your disks partitions (example: `/mnt/data/`) so your db container can work. This is a some kind of issue regarding Hyper-V sharing drivers... not really sure why.


## Versions

The versioning of this project matches the same tag of 
[Server Automation](https://github.com/evertramos/server-automation) and 
[NGINX proxy automation](https://github.com/evertramos/nginx-proxy-automation).

Table of compatibility:

docker-wordpress    |   nginx-proxy-automation  |   server-automation
:---:               |   :---:                   |   :---:
v0.5                |   v0.5                    |   v0.5

