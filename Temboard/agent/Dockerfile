FROM debian:buster-slim AS temboard-agent

RUN apt-get update && apt-get install -y lsb-release curl; \
	rm -rf /var/lib/apt/lists/*;

RUN echo deb http://apt.dalibo.org/labs $(lsb_release -cs)-dalibo main > /etc/apt/sources.list.d/dalibo-labs.list; \
    curl -fsSL -o /etc/apt/trusted.gpg.d/dalibo-labs.gpg https://apt.dalibo.org/labs/debian-dalibo.gpg; \
    apt update && apt install -y --no-install-recommends temboard-agent; 

RUN echo temboard-agent --version;

