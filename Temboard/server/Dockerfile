FROM debian:bullseye AS temboard-server

ARG TEMBOARD_VERSION

RUN useradd -m -s /bin/bash temboard; \
    mkdir -p /home/temboard/log/temboard; \
    mkdir -p /home/temboard/etc; \
    mkdir -p /home/temboard/bin; \
    echo '' > /home/temboard/log/temboard/temboard-auto-configure.log;

WORKDIR /home/temboard

ENV PGHOST=repository
ENV PGPORT=5432
ENV PGUSER=temboard
ENV PGPASSWORD=temboard
ENV LOGDIR=/home/temboard/log/temboard
ENV LOGFILE=/home/temboard/log/temboard/temboard-auto-configure.log
ENV ETCDIR=/home/temboard/etc
ENV VARDIR=/home/temboard/bin
ENV SYSUSER=root
ENV TEMBOARD_VERSION=${TEMBOARD_VERSION}
ENV TEMBOARD_PASSWORD=${PGPASSWORD}

RUN apt-get update -y && \
    apt-get install -y \
	sudo build-essential \
    curl \
    openssl \
    libncursesw5-dev \
    libxml2-dev \
    libgdal-dev \
    libproj-dev \
    libjson-c-dev \
    xsltproc \
    docbook-xsl \
    docbook-mathml \
    libpq-dev \
    protobuf-c-compiler \
    libjsoncpp-dev \
    libprotobuf-dev \
    libprotobuf-c-dev \
    proj-bin \
    python3-pip python3-setuptools python3-dev; \
	whereis python3 && ln -s /usr/bin/python3 /usr/bin/python && \
	pip install logutils argparse temboard psycopg2-binary;

RUN apt-get install -y ca-certificates \
    lsb-base lsb-release; \
    install -d /usr/share/postgresql-common/pgdg; \
    curl -k -o /usr/share/postgresql-common/pgdg/apt.postgresql.org.asc https://www.postgresql.org/media/keys/ACCC4CF8.asc; \
    echo "deb [signed-by=/usr/share/postgresql-common/pgdg/apt.postgresql.org.asc] https://apt.postgresql.org/pub/repos/apt $(lsb_release -cs)-pgdg main" > /etc/apt/sources.list.d/pgdg.list; \
    apt-get update -y; \
    apt-get install -y postgresql-14; \
    rm -rf /var/lib/apt/lists/*;

RUN echo "export PATH=$PATH:/usr/lib/postgresql/14/bin" >> /etc/profile;

RUN apt-get update -y; \
    apt-get install -y locales; \
    localedef -i en_US -c -f UTF-8 -A /usr/share/locale/locale.alias en_US.UTF-8;

ENV LANG en_US.utf8
ENV TZ America/Bahia

# Custom entrypoint
COPY ./docker-entrypoint.sh /home/temboard/
RUN chmod +x /home/temboard/docker-entrypoint.sh

ENTRYPOINT ["/home/temboard/docker-entrypoint.sh"]