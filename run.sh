#!/bin/bash

function configure(){
    mkdir -m 755 -p $(pwd)/data/postgresql/pgdata
    mkdir -m 755 -p $(pwd)/data/postgresql/sshkeys

    mkdir -m 755 -p $(pwd)/data/pgbarman/sshkeys
    mkdir -m 755 -p $(pwd)/data/pgbarman/log
    mkdir -m 755 -p $(pwd)/data/pgbarman/backupcfg
    mkdir -m 755 -p $(pwd)/data/pgbarman/backups

    ssh-keygen -b 4096 -t rsa -N '' -f $(pwd)/data/postgresql/sshkeys/id_rsa
    ssh-keygen -f ~/.ssh/id_rsa -y >> $(pwd)/data/postgresql/sshkeys/authorized_keys

    ssh-keygen -b 4096 -t rsa -N '' -f $(pwd)/data/pgbarman/sshkeys/id_rsa
    ssh-keygen -f ~/.ssh/id_rsa -y >> $(pwd)/data/pgbarman/sshkeys/authorized_keys

    ssh-keygen -f $(pwd)/data/pgbarman/sshkeys/id_rsa -y >> $(pwd)/data/postgresql/sshkeys/authorized_keys
    ssh-keygen -f $(pwd)/data/postgresql/sshkeys/id_rsa -y >> $(pwd)/data/pgbarman/sshkeys/authorized_keys

    chmod -R 755 $(pwd)/data/postgresql/sshkeys/*
    chmod -R 755 $(pwd)/data/pgbarman/sshkeys/*

    cp Barman/postgres-source-db.conf $(pwd)/data/pgbarman/backupcfg/.
}

function build(){
    docker compose --compatibility --project-name "postgresql-barman" build --memory 1g --no-cache;
}

function up(){
    docker compose --compatibility --project-name "postgresql-barman" up -d;
}

function up_with_temboard() {
    docker compose --compatibility --project-name "postgresql-temboard-barman" --profile with-temboard up -d;
}

function stop(){
    docker compose --compatibility --project-name "postgresql-barman" stop;
}

function drop(){
    docker compose --compatibility --project-name "postgresql-barman" down;
}

function drop_hard(){
    docker compose --compatibility --project-name "postgresql-barman" down --remove-orphans --volumes --rmi 'all' && \
    [ -d "./data" ] && sudo rm -rf ./data;
    docker builder prune -f;
}

function populate(){
    docker exec postgres-source-db psql -U dbadmin -d 'db' -p 5432 -c "$(cat ./Postgres/populate_dep_ti_adm_db_complete.sql)";
}

function seed(){
    docker exec postgres-source-db psql -U dbadmin -d 'db' -p 5432 -c "$(cat ./Postgres/populate_dep_ti_adm_db_seed.sql)";
}

function update(){
    local migration_file=$(ls -t ./migration | head -n 1)
    if [ -f "./migration/$migration_file" ]; then
        echo "Running migration file: $migration_file";
        docker exec postgres-source-db psql -U dbadmin -d 'db' -p 5432 -c "$(cat ./migration/$migration_file)";
    else
        echo "Migration file not found: $migration_file";
    fi
}

function dump(){
    docker exec postgres-source-db pg_dump -U dbadmin -d 'db' -p 5432 -f /tmp/db.sql;
    docker cp postgres-source-db:/tmp/db.sql ./data/pgbarman/backups/db.sql;
}

$1