#!/bin/bash

echo NOTE: MAKE SURE TO RUN THIS SCRIPT FROM THE DIRECTORY IT\'S IN

echo ------------------------------------------
echo Install MariaDB Server from official repos
echo ------------------------------------------

curl -LsS https://downloads.mariadb.com/MariaDB/mariadb_repo_setup | sudo bash && sudo apt-get install mariadb-server

echo -----------------------
echo Run Secure Installation
echo -----------------------

sudo mysql_secure_installation

echo ----------------------
echo SQL Table Setup Script
echo ----------------------

cat setup.sql
sudo mariadb < setup.sql

echo ---------------
echo Create New User
echo ---------------

echo -n "Username: "
read username

echo -n "Password: "
read -s password

sudo mariadb -e "CREATE USER '$user'@'%' IDENTIFIED BY '$password'; GRANT ALL ON *.* to '$user'@'%' IDENTIFIED BY '$password' WITH GRANT OPTION;"

echo ------------------------------
echo Append settings to config file
echo ------------------------------

cat cnf-append.txt | sudo tee -a /etc/mysql/my.cnf

echo Done.

sudo mariadb -e "SHOW DATABASES;"
