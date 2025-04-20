#!/bin/bash

echo "Running setup.sh for local development environment..."

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
if [ ! -f docker-compose-local.yml ]; then
    echo "docker-compose-local.yml file not found. Please ensure you are in the correct directory."
    exit 1
fi

# Check if the .env file exists
#if [ ! -f .env ]; then
#    echo ".env file not found. Please create a .env file with the necessary environment variables."
#    exit 1
#fi

# Start the Docker containers
docker compose -f docker-compose-local.yml up -d


exit 0
