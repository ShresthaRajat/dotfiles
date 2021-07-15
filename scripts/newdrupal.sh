#!/bin/sh
DRUPAL="9.1.8"

# Update package lists then install apache, php and their dependencies
sudo apt update
sudo apt install -y apache2 mysql-server
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
sudo chmod 755 -R /var/www/html
sudo systemctl restart apache2

sudo mysql <<-EOF
CREATE USER 'admin'@'localhost' IDENTIFIED BY 'admin';
DROP DATABASE drupal;
CREATE DATABASE drupal;
GRANT ALTER, SELECT, INSERT, UPDATE, CREATE, DROP, DELETE, INDEX ON drupal.* TO 'admin'@'localhost';
FLUSH PRIVILEGES;
EOF

mysql -u admin -pkrwxUc5LL7vWGKa -h mcd-staging.chrzo1hyl6wu.us-east-2.rds.amazonaws.com


admin
magdotnet
krwxUc5LL7vWGKa
mcd-staging.chrzo1hyl6wu.us-east-2.rds.amazonaws.com

$databases['default']['default'] = array (
  'database' => 'magdotnet',
  'username' => 'admin',
  'password' => 'krwxUc5LL7vWGKa',
  'prefix' => '',
  'host' => 'mcd-staging.chrzo1hyl6wu.us-east-2.rds.amazonaws.com',
  'port' => '3306',
  'namespace' => 'Drupal\\Core\\Database\\Driver\\mysql',
  'driver' => 'mysql',
);



# <?php
# require __DIR__ . '/vendor/autoload.php';

# $dotenv = Dotenv\Dotenv::createImmutable(__DIR__);
# $dotenv->load();
# $s3_bucket = $_ENV['S3_BUCKET'];
# echo $s3_bucket;
# ?>
