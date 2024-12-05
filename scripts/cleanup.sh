#!/bin/bash

read -p "Do you really want to do this? This action cannot be undone. (yes/no): " confirm

if [ "$confirm" != "yes" ]; then
    echo "Operation cancelled."
    exit 1
fi

# Stop all running containers
docker stop $(docker ps -q)

# Remove all containers
docker rm $(docker ps -a -q)

# Remove all images
docker rmi $(docker images -q)

# Remove all volumes
docker volume rm $(docker volume ls -q)

# Remove all networks
docker network rm $(docker network ls -q)

# Prune the system to remove unused data
docker system prune -a -f --volumes

echo "All Docker images, containers, volumes, and cache have been removed."
