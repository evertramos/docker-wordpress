#!/bin/bash

echo "Backup script for local development environment..."

# Get the script name and its file real path
SCRIPT_PATH="$(dirname "$(readlink -f "$0")")"

BACKUP_DESTINATION="${SCRIPT_PATH}/../backups"
WORDPRESS_DB_NAME=wordpress
DOCKER_WORDPRESS_MYSQL_ROOT_PASSWORD=root

# Check if all services are running
if ! docker compose -f "${SCRIPT_PATH}/../docker-compose-local.yml" ps | grep -q "Up"; then
    echo "Not all services are running. Please start the services and try again."
    exit 1
fi

# Create backup destination if directory does not exist
mkdir -p "${BACKUP_DESTINATION}"

# Backup the database
docker compose -f "${SCRIPT_PATH}/../docker-compose-local.yml" exec -T mysql-db \
    mysqldump -u root -p"${DOCKER_WORDPRESS_MYSQL_ROOT_PASSWORD}" "${WORDPRESS_DB_NAME}" > "${BACKUP_DESTINATION}/db_backup.sql"

# Backup the WordPress files
docker compose -f "${SCRIPT_PATH}/../docker-compose-local.yml" exec wordpress-site sh -c \
  "tar -C /var/www/html -vczf /tmp/wordpress-backup.tar.gz wp-content wp-config.php"
docker compose -f "${SCRIPT_PATH}/../docker-compose-local.yml" cp wordpress-site:/tmp/wordpress-backup.tar.gz "${BACKUP_DESTINATION}/"
docker compose -f "${SCRIPT_PATH}/../docker-compose-local.yml" exec wordpress-site rm /tmp/wordpress-backup.tar.gz


exit 0
