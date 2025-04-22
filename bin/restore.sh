#!/bin/bash

echo "Restore script for local development environment..."

# Get the script name and its file real path
SCRIPT_PATH="$(dirname "$(readlink -f "$0")")"

BACKUP_SOURCE="${SCRIPT_PATH}/../backups"
WORDPRESS_DB_NAME=wordpress
DOCKER_WORDPRESS_MYSQL_ROOT_PASSWORD=root

# Check if all services are running
if ! docker compose -f "${SCRIPT_PATH}/../docker-compose-local.yml" ps | grep -q "Up"; then
    echo "Not all services are running. Please start the services and try again."
    exit 1
fi

# Restore the database
docker compose -f "${SCRIPT_PATH}/../docker-compose-local.yml" exec -T mysql-db \
    mysql -u root -p"${DOCKER_WORDPRESS_MYSQL_ROOT_PASSWORD}" "${WORDPRESS_DB_NAME}" < "${BACKUP_SOURCE}/db_backup.sql"

# Restore the WordPress files
docker compose -f "${SCRIPT_PATH}/../docker-compose-local.yml" cp "${BACKUP_SOURCE}/wordpress-backup.tar.gz" wordpress-site:/tmp/
docker compose -f "${SCRIPT_PATH}/../docker-compose-local.yml" exec wordpress-site sh -c \
  "tar -xzf /tmp/wordpress-backup.tar.gz -C /var/www/html && rm /tmp/wordpress-backup.tar.gz"

exit 0

