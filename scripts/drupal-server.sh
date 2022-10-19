#!/bin/sh
# A more complex drupal setup
# userdata

DRUPAL="9.1.10"
EFS_MOUNT="/mnt/efs"
DRUPAL_PATH="/app/drupal/efs"

# Update package lists then install apache, php and their dependencies
sudo apt-get update
sudo apt-get install -y nfs-common
sudo apt-get install -y apache2
sudo apt-get install -y php
sudo apt-get install -y php-cli unzip
sudo apt-get install -y php-dom php-gd php-simplexml php-xml
sudo apt-get install -y php-common php-mysql php-mbstring
sudo apt-get install -y php-memcached
sudo apt-get install -y mysql-client-core-8.0

# Download Drupal and set it up on ${DRUPAL_PATH}
cd ${DRUPAL_PATH}
wget https://ftp.drupal.org/files/projects/drupal-$DRUPAL.tar.gz
tar -xvf drupal-$DRUPAL.tar.gz
rm index.html
mv drupal-$DRUPAL/* .
mv drupal-$DRUPAL/.* .
rmdir drupal-$DRUPAL
rm drupal-$DRUPAL.tar.gz

# Remove preconfigured folders and create symlink from efs mount
rm -rf ${DRUPAL_PATH}/modules
rm -rf ${DRUPAL_PATH}/profiles
rm -rf ${DRUPAL_PATH}/sites
rm -rf ${DRUPAL_PATH}/themes
sudo ln -s ${EFS_MOUNT}/modules ${DRUPAL_PATH}/modules
sudo ln -s ${EFS_MOUNT}/profiles ${DRUPAL_PATH}/profiles
sudo ln -s ${EFS_MOUNT}/sites ${DRUPAL_PATH}/sites
sudo ln -s ${EFS_MOUNT}/themes ${DRUPAL_PATH}/themes

# fix all permissions and restart apache2
sudo chown -R 33:33 ${DRUPAL_PATH}
sudo chmod 755 -R ${DRUPAL_PATH}
sudo systemctl restart apache2
