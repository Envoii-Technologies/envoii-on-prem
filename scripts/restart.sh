#!/bin/sh

read -p "Do you want to restart the envoii application platform? (yes/no or y/n): " confirm

if [ "$confirm" != "yes" ] && [ "$confirm" != "y" ]; then
    echo "Cancelled."
    exit 1
fi

echo "Restarting services..."

docker compose restart
