#!/bin/bash
set -e

run_temboard_agent() {
	if [ ! -f "/var/lib/postgresql/data/configured" ]; then
		/usr/local/share/temboard-agent/purge.sh {$PGDATA};
		/usr/local/share/temboard-agent/auto_configure.sh {$TEMBOARD_UI_URL};
		sudo -u ${POSTGRES_USER} temboard-agent -c /etc/temboard-agent/data/pgdata/temboard-agent.conf fetch-key --force;
		touch /var/lib/postgresql/data/configured;
	else
		echo "Temboard agent Configured"
	fi;

    sudo -u ${POSTGRES_USER} temboard-agent -c /etc/temboard-agent/data/pgdata/temboard-agent.conf;
}

function customize {
#	id
	cp -R /tmp/.ssh/* /root/.ssh/
#	ls -ltr /tmp/.ssh
#	ls -ltr /root/.ssh
	chmod 700 /root/.ssh
	chmod 644 /root/.ssh/id_rsa.pub
	chmod 600 /root/.ssh/id_rsa
	chmod 600 /root/.ssh/authorized_keys

	su - postgres -c "cp -R /tmp/.ssh/* ~postgres/.ssh/ && chmod 700 ~postgres/.ssh && chmod 644 ~postgres/.ssh/id_rsa.pub && chmod 600 ~postgres/.ssh/id_rsa && chmod 600 ~postgres/.ssh/authorized_keys"

	/usr/sbin/sshd 2>&1

	sleep 30 & run_temboard_agent
}

customize & /usr/local/bin/docker-entrypoint.sh "$@"

/bin/bash -c "tail -f /dev/null"