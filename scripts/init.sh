#!/bin/sh

read -p "Do you want to initialize the envoii application platform? you might need to answer a few questions. (yes/no or y/n): " confirm

if [ "$confirm" != "yes" ] && [ "$confirm" != "y" ]; then
    echo "Cancelled."
    exit 1
fi

echo "Initializing platform..."

docker compose pull

touch .env
