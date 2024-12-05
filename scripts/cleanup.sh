#!/bin/sh

read -p "Do you really want to do this? This action cannot be undone. (yes/no or y/n): " confirm

if [ "$confirm" != "yes" ] && [ "$confirm" != "y" ]; then
    echo "Operation cancelled."
    exit 1
fi

echo "Proceeding with the cleanup..."

# # Delete .env file if it exists
# env_file="./.env"
# if [ -f "$env_file" ]; then
#     rm "$env_file"
#     echo ".env file deleted."
# else
#     echo ".env file not found."
# fi

# Stop all running containers
running_containers=$(docker ps -q)
if [ -n "$running_containers" ]; then
    docker stop $running_containers
else
    echo "No running containers to stop."
fi

# Remove all containers
containers=$(docker ps -a -q)
if [ -n "$containers" ]; then
    docker rm $containers
else
    echo "No containers found for deletion."
fi

# Remove all images
images=$(docker images -q)
if [ -n "$images" ]; then
    docker rmi $images
else
    echo "No images found for deletion."
fi

# Remove all volumes
volumes=$(docker volume ls -q)
if [ -n "$volumes" ]; then
    docker volume rm $volumes
else
    echo "No volumes found for deletion."
fi

# Remove all networks
networks=$(docker network ls --format '{{.ID}} {{.Name}}' | grep -vE 'bridge|host|none' | awk '{print $1}')
if [ -n "$networks" ]; then
    docker network rm $networks
else
    echo "No networks found for deletion."
fi

# Prune the system to remove unused data
docker system prune -a -f --volumes

echo "All Docker images, containers, volumes, and cache have been removed."
