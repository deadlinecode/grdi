FROM ubuntu:jammy

WORKDIR /app
COPY scripts ./scripts

RUN apt-get -y update; apt-get -y install curl

RUN ./scripts/install.sh

WORKDIR /app/runner

RUN ./bin/installdependencies.sh

CMD ["../scripts/start.sh"]