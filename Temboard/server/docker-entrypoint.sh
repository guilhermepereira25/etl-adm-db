#!/bin/bash
set -e

# Start temboard
start_temboard() {
    # Start temboard
    echo "Starting temboard..."
}

start_temboard "$@"

/bin/bash -c "tail -f /dev/null"