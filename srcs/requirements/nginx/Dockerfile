FROM debian:oldstable

RUN apt-get -y update && apt-get install -y nginx && apt-get install openssl -y

COPY ./tools/script.sh /

CMD ["/script.sh"]