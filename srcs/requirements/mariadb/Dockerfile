FROM debian:oldstable


RUN apt-get update && apt-get install -y \
    apt-utils \
    mariadb-server \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

COPY ./tools/50-server.cnf /etc/mysql/mariadb.conf.d/

COPY ./tools/script.sh /

CMD ["/script.sh"]