#!/bin/bash

mysqld_safe --datadir='/var/lib/mysql' &

sleep 5

DB_NAME=interstellar

mysql -u root -e "UPDATE mysql.user SET plugin = 'mysql_native_password' WHERE User = 'root' AND Host = 'localhost';"
mysql -u root -e "FLUSH PRIVILEGES;"

mysql -u root -e "CREATE DATABASE IF NOT EXISTS $DB_NAME;"

mysql -u root -e "GRANT ALL PRIVILEGES ON interstellar.* TO 'root'@'127.0.0.1';";
mysql -u root -e "FLUSH PRIVILEGES;";

if [ -f /docker-entrypoint-initdb.d/init.sql ]; then
    mysql -u root $DB_NAME < /docker-entrypoint-initdb.d/init.sql
else
    echo "No init.sql found!"
fi

apache2-foreground
