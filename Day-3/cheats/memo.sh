# Remise en route

# Create image
docker image build -t askbob/webapp .

# Create network
docker network create askbob-network

# Create PG
docker container run \
    --name askbob-pg \
    --publish 5432:5432 \
    --network askbob-network \
    --detach \
    --rm \
    postgres

# Run Askbob webapp
docker container run \
    --name askbob-webapp \
    --publish 3000:3000 \
    --network askbob-network \
    --env-file .env \
    --rm \
    askbob/webapp

# 1 - Erreur asset compiler

# RUN apt-get update && \
#     apt-get install -y nodejs

# 2 - Sortir les variables d'env du dossier => .dockerignore et .env pour docker

# 3 - Enjoy
