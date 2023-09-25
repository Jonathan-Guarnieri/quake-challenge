#!/bin/bash
set -e

create_multiple_databases() {
  sql="CREATE USER $POSTGRES_USER WITH SUPERUSER PASSWORD '$POSTGRES_PASSWORD';"
  echo "$sql"
  for db in $(echo $POSTGRES_MULTIPLE_DATABASES | tr ',' ' '); do
    sql="$sql DROP DATABASE IF EXISTS $db;"
    sql="$sql CREATE DATABASE $db WITH OWNER = $POSTGRES_USER;"
  done
  psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" -c "$sql"
}

if [ "$POSTGRES_MULTIPLE_DATABASES" ]; then
  create_multiple_databases
fi
