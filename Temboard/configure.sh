#!/bin/bash
set -e

configure() {
    mkdir -m 775 $(pwd)/server/data/repository/postgresql/pgdata
    mkdir -m 775 $(pwd)/server/data/temboard-server/temboard
    mkdir -m 775 $(pwd)/server/data/temboard-server/log
}

configure