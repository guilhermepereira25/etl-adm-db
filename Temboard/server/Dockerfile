FROM python:3.11.9-slim-bullseye AS temboard-server

ENV PGHOST=temboard-repository
ENV PGPORT=6433
ENV PGUSER=postgres
ENV PGPASS=postgres

RUN apt-get update && apt-get install -y lsb-release curl openssl && apt-get clean all;

# Install Temboard
RUN echo deb http://apt.dalibo.org/labs $(lsb_release -cs)-dalibo main > /etc/apt/sources.list.d/dalibo-labs.list \
    && curl -fsSL -o /etc/apt/trusted.gpg.d/dalibo-labs.gpg https://apt.dalibo.org/labs/debian-dalibo.gpg \
    && apt-get update; \
    apt-get install -y temboard; \
    rm -rf /var/lib/apt/lists/*;

RUN echo temboard --version;

# Custom entrypoint
COPY ./docker-entrypoint.sh /
RUN chmod +x docker-entrypoint.sh

EXPOSE 8888
ENTRYPOINT ["./docker-entrypoint.sh"]