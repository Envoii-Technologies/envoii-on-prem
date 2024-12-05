#!/bin/sh

read -p "Do you want to initialize the envoii application platform? you might need to answer a few questions. (yes/no or y/n): " confirm

if [ "$confirm" != "yes" ] && [ "$confirm" != "y" ]; then
    echo "Cancelled."
    exit 1
fi

echo "Initializing platform..."

if [ -f .env ]; then
    . .env
else
    echo ".env file not found. Please create a .env file."
    exit 1
fi

# Pull images
docker pull postgres:$POSTGRES_VERSION
docker pull mongo:$MONGODB_VERSION
docker pull minio/minio:$MINIO_VERSION

# Save images
docker save -o ./images/postgres.tar postgres:$POSTGRES_VERSION
docker save -o ./images/mongo.tar mongo:$MONGODB_VERSION
docker save -o ./images/minio.tar minio/minio:$MINIO_VERSION

# Remove original images
docker rmi postgres:$POSTGRES_VERSION -f
docker rmi mongo:$MONGODB_VERSION -f
docker rmi minio/minio:$MINIO_VERSION -f

# Load images from local source
docker load -i ./images/postgres.tar
docker load -i ./images/minio.tar
docker load -i ./images/mongo.tar

touch .env
