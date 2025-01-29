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

mv /wp-config.php /var/www/html/wp-config.php


sed -i -r "s/db1/$db_name/1"   wp-config.php
sed -i -r "s/user/$db_user/1"  wp-config.php
sed -i -r "s/pwd/$db_pwd/1"    wp-config.php

#curl -s https://api.wordpress.org/secret-key/1.1/salt/ > salts.txt
# Supprime manuellement les anciennes clés
#awk '/AUTH_KEY/,/NONCE_SALT/{next} {print}' wp-config.php > wp-config.tmp
# Réinsère les nouvelles clés entre /**#@+ et /**#@- :
#awk '/#@+/{print; while(getline < "salts.txt") print; next}1' wp-config.tmp > wp-config.php
#rm salts.txt wp-config.tmp

# // Install WP and config Admin and User
wp core install --url=$DOMAIN_NAME/ --title=$WP_TITLE --admin_user=$WP_ADMIN_USR --admin_password=$WP_ADMIN_PWD --admin_email=$WP_ADMIN_EMAIL --skip-email --allow-root
wp user create $WP_USR $WP_EMAIL --role=author --user_pass=$WP_PWD --allow-root

sed -i 's/listen = \/run\/php\/php7.4-fpm.sock/listen = 9000/g' /etc/php/7.4/fpm/pool.d/www.conf

mkdir -p /run/php


/usr/sbin/php-fpm7.4 -F