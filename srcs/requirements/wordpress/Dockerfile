FROM debian:oldstable

RUN apt update -y

RUN apt install php-fpm php-mysql -y

RUN apt install -y curl

RUN apt install -y wordpress

COPY ./tools/script.sh /

COPY ./tools/wp-config.php /

CMD ["/script.sh"]