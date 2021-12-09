#!/bin/bash

sed -i 's|PATHVAR|`pwd`/data|g' sql/load.sql

${UMBRA_LOCATION}/bin/sql --createdb /tmp/umbra-scratch/my.db sql/create-role.sql sql/load.sql
${UMBRA_LOCATION}/bin/server --address 127.0.0.1 /tmp/scratch/my.db &

sleep 2

${UMBRA_LOCATION}/bin/sql sql/cte-query.sql
