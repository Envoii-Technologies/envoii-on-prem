#!/bin/sh

read -p "Do you want to start the envoii application platform? (yes/no or y/n): " confirm

if [ "$confirm" != "yes" ] && [ "$confirm" != "y" ]; then
    echo "Cancelled."
    exit 1
fi

echo "Starting services..."

docker compose up -d
