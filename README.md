# Docker Wordpress 🚀

<p align="center">
    <a target="_blank" href="https://docs.docker.com/"><img src="https://img.shields.io/badge/Docker-2CA5E0?style=for-the-badge&logo=docker&logoColor=white" /></a>
    <a target="_blank" href="https://developer.wordpress.org/"><img src="https://img.shields.io/badge/Wordpress-21759B?style=for-the-badge&logo=wordpress&logoColor=white" /></a>
</p>

![wordpress-docker-letsencrypt](https://github.com/evertramos/images/raw/master/wordpress.jpg)


## How to start 🔰

This script was first designed to work along with [**Server Automation**](https://github.com/evertramos/server-automation),
where you will be able to start a new WordPress site in less than a minute. 

### Developing locally

If you want to run this project locally, you can do it by running the following command:

```bash
git clone https://github.com/evertramos/docker-wordpress.git
cd docker-wordpress
./setup.sh
```

This will start the containers and create a new database for you.

### Migrating from local to production

If you want to migrate your local site (wordpress files and database) to production, 
you can do it by running the following command:

:construction: Work in progress

## Known Issues 💭 

### 1. Azure

Running docker on Azure servers you must mount your database in your disks partitions (example: `/mnt/data/`) 
so your db container can work. 

> This is a some kind of issue regarding Hyper-V sharing drivers... not really sure why. If you know what the issue id,
> please, open an issue on GitHub and I will be glad to update this documentation.

---

## Versions

The versioning of this project matches the same tag of 
[Server Automation](https://github.com/evertramos/server-automation) and 
[NGINX proxy automation](https://github.com/evertramos/nginx-proxy-automation).

Table of compatibility:

docker-wordpress    |   nginx-proxy-automation  |   server-automation
:---:               |   :---:                   |   :---:
v0.5                |   v0.5                    |   v0.5

