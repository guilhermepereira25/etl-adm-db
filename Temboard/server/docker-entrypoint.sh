#!/bin/bash
set -e

configure() {
    sudo -iu temboard echo "export PGHOST=${PGHOST}" >> /home/temboard/.bashrc \
    && sudo -iu temboard echo "export PGPORT=${PGPORT}" >> /home/temboard/.bashrc \
    && sudo -iu temboard echo "export PGUSER=${PGUSER}" >> /home/temboard/.bashrc \
    && sudo -iu temboard echo "export PGPASSWORD=${PGPASSWORD}" >> /home/temboard/.bashrc;
}

run_temboard() {
    echo "Running temboard..."

    if [ ! -f "/home/temboard/configured" ]; then
		echo "Configure Temboard.";
		# sudo -iu temboard psql -h ${PGHOST} -p ${PGPORT} -U ${PGUSER} -w ${PGPASSWORD} -d ${TEMBOARD_DATABASE} -c "CREATE EXTENSION IF NOT EXISTS pg_stat_statements;";
		/bin/bash /usr/local/share/temboard/auto_configure.sh;
		# sudo -iu temboard psql -h ${PGHOST} -p ${PGPORT} -U ${PGUSER} -w ${PGPASSWORD} -d ${TEMBOARD_DATABASE} -c "CREATE EXTENSION IF NOT EXISTS pg_stat_statements;";
		cp /etc/ssl/private/ssl-cert-snakeoil.key /home/temboard/etc/;
		cp /home/temboard/etc/signing-* /home/temboard/;
		touch /home/temboard/configured;
	else
		temboard --version;
	fi;

    echo "Running command to start temboard...";
	sudo -iu root temboard -c /home/temboard/temboard.conf 2>&1;
}

start() {
    configure
    sleep 30 & run_temboard
}

start "$@"