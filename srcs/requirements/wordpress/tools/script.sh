#!/bin/bash

mkdir -p /var/www/
mkdir -p /var/www/html

cd /var/www/html

rm -rf *

curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar 

chmod +x wp-cli.phar 

mv wp-cli.phar /usr/local/bin/wp

wp core download --allow-root

mv /var/www/html/wp-config-sample.php /var/www/html/wp-config.php

sed -i -r "s/database_name_here/$db_name/1"   wp-config.php
sed -i -r "s/username_here/$db_user/1"  wp-config.php
sed -i -r "s/password_here/$db_pwd/1"    wp-config.php

sed -i -r "s/localhost/mariadb/1"    wp-config.php

#curl -s https://api.wordpress.org/secret-key/1.1/salt/ > salts.txt
# Supprime manuellement les anciennes clés
#awk '/AUTH_KEY/,/NONCE_SALT/{next} {print}' wp-config.php > wp-config.tmp
# Réinsère les nouvelles clés entre /**#@+ et /**#@- :
#awk '/#@+/{print; while(getline < "salts.txt") print; next}1' wp-config.tmp > wp-config.php
#rm salts.txt wp-config.tmp


sed -i 's/listen = \/run\/php\/php7.4-fpm.sock/listen = 9000/g' /etc/php/7.4/fpm/pool.d/www.conf

mkdir -p /run/php


/usr/sbin/php-fpm7.4 -F