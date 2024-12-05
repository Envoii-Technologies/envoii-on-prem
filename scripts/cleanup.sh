#!/bin/bash

read -p "Do you really want to do this? This action cannot be undone. (yes/no): " confirm

if [ "$confirm" != "yes" ]; then
    echo "Operation cancelled."
    exit 1
fi

echo "Proceeding with the cleanup..."

# Stop all running containers
docker stop $(docker ps -q)

# Remove all containers
if ! docker rm $(docker ps -a -q); then
    echo "No containers found for deletion."
fi
docker rm $(docker ps -a -q)

# Remove all images
docker rmi $(docker images -q); then
    echo "No images found for deletion."
fi
docker rmi $(docker images -q)

# Remove all volumes
docker volume rm $(docker volume ls -q); then
    echo "No volumes found for deletion."
fi
docker volume rm $(docker volume ls -q)

# Remove all networks
docker network rm $(docker network ls -q); then
    echo "No networks found for deletion."
fi
docker network rm $(docker network ls -q)

# Prune the system to remove unused data
docker system prune -a -f --volumes

echo "All Docker images, containers, volumes, and cache have been removed."
