#!/bin/bash

set -eu

sed "s|PATHVAR|`pwd`/data|g" sql/load.sql > sql/load-pwd.sql

rm -rf /tmp/umbra-scratch/
mkdir /tmp/umbra-scratch/

${UMBRA_LOCATION}/bin/sql \
    --createdb /tmp/umbra-scratch/my.db \
    sql/create-role.sql \
    sql/load-pwd.sql

${UMBRA_LOCATION}/bin/server --address 127.0.0.1 /tmp/umbra-scratch/my.db &

sleep 1

psql -U postgres -h localhost < sql/cte-query.sql
