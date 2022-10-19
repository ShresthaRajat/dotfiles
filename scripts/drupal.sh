#!/bin/sh
# Simple script to install/configure a base drupal server with apache, php, and mysql
# userdata

DRUPAL="9.1.8"
DB_PASS="password"
DB_URL="something.us-east-2.rds.amazonaws.com"

# Update package lists then install apache, php and their dependencies
sudo apt update
sudo apt install -y apache2
sudo apt install -y php 
sudo apt install -y php-dom php-gd php-simplexml php-xml
sudo apt install -y php-common php-mysql php-mbstring

# Download Drupal and set it up on /var/www/html
cd /var/www/html

wget https://ftp.drupal.org/files/projects/drupal-$DRUPAL.tar.gz
tar -xvf drupal-$DRUPAL.tar.gz 
rm index.html
mv drupal-$DRUPAL/* .
mv drupal-$DRUPAL/.* .
rmdir drupal-$DRUPAL

# Change requred permissions and owners
sudo chown -R www-data:www-data /var/www/html
sudo chmod 777 -R /var/www/html
sudo systemctl restart apache2

# need to do this part manually then restart apache2
# sudo vim /etc/apache2/apache2.conf 
# edit Allowoptions to All

# Purge and repopulate data with the given database
mysql -u admin -p$DB_PASS -h $DB_URL <<-EOF
DROP DATABASE drupal;
CREATE DATABASE drupal;
GRANT ALTER, SELECT, INSERT, UPDATE, CREATE, DROP, DELETE, INDEX ON drupal.* TO admin;
FLUSH PRIVILEGES
EOF
mysql -u rdsadmin -p$DB_PASS -h $DB_URL -D drupal < back.sql