#!/bin/bash
set -e

psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" --dbname "$POSTGRES_DB" <<-EOSQL
    CREATE DATABASE metastore;
    CREATE USER hive WITH ENCRYPTED PASSWORD 'hive';
    GRANT ALL PRIVILEGES ON DATABASE metastore TO hive;

    CREATE DATABASE ranger;
    CREATE USER ranger WITH ENCRYPTED PASSWORD 'ranger';
    GRANT ALL PRIVILEGES ON DATABASE ranger TO ranger;

    CREATE DATABASE ldap;
    CREATE USER ldap WITH ENCRYPTED PASSWORD 'ldap';
    GRANT ALL PRIVILEGES ON DATABASE ldap TO ldap;

    CREATE DATABASE keycloak;
    CREATE USER keycloak WITH ENCRYPTED PASSWORD 'keycloak';
    GRANT ALL PRIVILEGES ON DATABASE keycloak TO keycloak;

    CREATE DATABASE trino_gateway;
    CREATE USER trino_gateway WITH ENCRYPTED PASSWORD 'trino_gateway';
    GRANT ALL PRIVILEGES ON DATABASE trino_gateway TO trino_gateway;
EOSQL