# Create PG
docker container run \
    --name postgresql \
    --publish 5432:5432 \
    --env POSTGRES_USER=steevie \
    --env POSTGRES_PASSWORD=wonder \
    --env POSTGRES_DB=superstition \
    --detach \
    postgres

docker container run \
    --name postgresql \
    --publish 5432:5432 \
    --env POSTGRES_USER=pix \
    --detach \
    postgres:10-alpine

psql --host=localhost --username=steevie --dbname=superstition

# Create Pgadmin
docker container run \
    --name pgadmin \
    --publish 5050:5050 \
    --detach \
    fenglc/pgadmin4

# With network
docker network create network
docker network connect network postgresql
docker network connect network pgadmin

# BONUS
# Create role
psql --host=localhost --username=steevie --dbname=superstition
> CREATE ROLE lala;
> SELECT rolname FROM pg_roles;

# Recreate container
docker container stop postgresql
docker container rm postgresql
docker container run \
    --name postgresql \
    --publish 5432:5432 \
    --env POSTGRES_USER=steevie \
    --env POSTGRES_PASSWORD=wonder \
    --env POSTGRES_DB=superstition \
    --detach \
    postgres

# Role doesn't exist anymore
psql --host=localhost --username=steevie --dbname=superstition
> SELECT rolname FROM pg_roles;
docker container stop postgresql
docker container rm postgresql

# With Volume
docker volume create my_volume
docker container run \
    --name postgresql \
    --publish 5432:5432 \
    --network my_network \
    --mount source=my_volume,target=/var/lib/postgresql/data \
    --env POSTGRES_USER=steevie \
    --env POSTGRES_PASSWORD=wonder \
    --env POSTGRES_DB=superstition \
    --detach \
    postgres

# Create role
psql --host=localhost --username=steevie --dbname=superstition
> CREATE ROLE lala;
> SELECT rolname FROM pg_roles;

# Recreate container
docker container stop postgresql
docker container rm postgresql
docker container run \
    --name postgresql \
    --publish 5432:5432 \
    --network my_network \
    --mount source=my_volume,target=/var/lib/postgresql/data \
    --env POSTGRES_USER=steevie \
    --env POSTGRES_PASSWORD=wonder \
    --env POSTGRES_DB=superstition \
    --detach \
    postgres

# Role still exists !
psql --host=localhost --username=steevie --dbname=superstition
> SELECT rolname FROM pg_roles;

# Cleaning time !
docker container stop postgresql pgadmin
docker container prune -f
docker network rm my_network
docker volume rm my_volume
 









 docker container stop postgresql