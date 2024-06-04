#!/bin/bash
set -e

configure() {
    mkdir -p 775 $(pwd)/server/data/temboard-repository/postgresql/pgdata
    mkdir -p 775 $(pwd)/server/data/temboard-server/temboard
    mkdir -p 775 $(pwd)/server/data/temboard-server/log

    mkdir -p 775 $(pwd)/agent/data/temboard-agent/temboard
    mkdir -p 775 $(pwd)/agent/data/temboard-agent/log
}

configure