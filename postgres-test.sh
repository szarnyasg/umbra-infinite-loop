#!/bin/bash

set -eu

sed "s|PATHVAR|/data|g" sql/load.sql > sql/load-container.sql

rm -rf /tmp/umbra-scratch/
mkdir /tmp/umbra-scratch/

docker rm -f postgres-mwe-container

docker run --rm \
    --publish=5432:5432 \
    --name postgres-mwe-container \
    --env POSTGRES_DATABASE=ldbcsnb \
    --env POSTGRES_HOST_AUTH_METHOD=trust \
    --volume=`pwd`/postgres_data:/var/lib/postgresql/data:z \
    --volume=`pwd`/data:/data:z \
    --detach \
    postgres:14.1

sleep 3

cat sql/load-container.sql  | docker exec -i postgres-mwe-container psql -U postgres
cat sql/cte-query.sql | docker exec -i postgres-mwe-container psql -U postgres
