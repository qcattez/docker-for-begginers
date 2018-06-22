# Modifs code Askbob
Modification de config/database.yml
Ajout de DATABASE_HOST au fichier .env
Ajout du fichier log/development.log

# Create PG
docker container run \
    --name askbob-pg \
    --publish 5432:5432 \
    --detach \
    --rm \
    postgres

# Create network
docker network create network
docker network connect network askbob-pg

# Run migrations
docker container run \
    --name askbob-migrations \
    --network network \
    --env-file .env \
    --rm \
    askbob/webapp rake db:setup

# Run Askbob webapp
docker container run \
    --name askbob-webapp \
    --publish 3000:3000 \
    --network network \
    --env-file .env \
    --rm \
    askbob/webapp

# Debug container
docker container run \
    --name askbob-webapp \
    --publish 3000:3000 \
    --network network \
    --env-file .env \
    --rm \
    -ti askbob/webapp /bin/bash