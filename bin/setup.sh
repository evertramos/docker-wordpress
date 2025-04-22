#!/bin/bash

echo "Running setup.sh for local development environment..."

COMMAND=${1:-"up"}

# Get the script name and its file real path
SCRIPT_PATH="$(dirname "$(readlink -f "$0")")"

# Check if Docker is running
if ! docker info > /dev/null 2>&1; then
    echo "Docker is not running. Please start Docker and try again."
    exit 1
fi

# Check if Docker Compose is installed
if ! command -v docker compose &> /dev/null; then
    echo "Docker Compose is not installed. Please install Docker Compose and try again."
    exit 1
fi

# Check if the Docker Compose file exists
if [ ! -f "${SCRIPT_PATH}/../docker-compose-local.yml" ]; then
    echo "docker-compose-local.yml file not found. Please ensure you are in the correct directory."
    exit 1
fi

# Check if the .env file exists
#if [ ! -f .env ]; then
#    echo ".env file not found. Please create a .env file with the necessary environment variables."
#    exit 1
#fi

# Run the Docker Compose command
if [ "$COMMAND" != "up" ]; then
    docker compose -f "${SCRIPT_PATH}/../docker-compose-local.yml" "${COMMAND}"
    exit 0
fi

# Start the Docker containers
docker compose -f "${SCRIPT_PATH}/../docker-compose-local.yml" up -d


exit 0
