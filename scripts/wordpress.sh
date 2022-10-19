#!/bin/bash -e
# Simple script to install a wordpress server
# userdata

clear
echo "============================================"
echo "Dependencies Installtion"
echo "============================================"
apt-get update
apt-get upgrade -y
sudo apt install  php libapache2-mod-php mysql-server php-mysql -y
apt-get install php7.2-mysql
apt-get update
apt install php php-curl php-gd php-mbstring php-xml php-xmlrpc php-soap php-intl php-zip -y
apt install unzip
echo "============================================"
echo "WordPress Install Script"
echo "============================================"

echo "Database Name: "
read -e dbname
echo "Database User: "
read -e dbuser
echo "Database Password: "
read -s dbpass

echo "============================================"
echo "Set Root user password"
echo "============================================"
echo "Database Root User Password: "
read -s dbroot
echo "run install? (y/n)"
read -e run
if [ "$run" == n ] ; then
exit
else
echo "============================================"
echo "A robot is now installing WordPress for you."
echo "============================================"
#download wordpress
cd /var/www/html

wget http://wordpress.org/latest.zip
#unzip wordpress
unzip latest.zip

rm -rf latest.zip

chown -R www-data:www-data wordpress
#change dir to wordpress
cd wordpress
#copy file to parent dir
#create wp config
cp wp-config-sample.php wp-config.php
#set database details with perl find and replace
perl -pi -e "s/database_name_here/$dbname/g" wp-config.php
perl -pi -e "s/username_here/$dbuser/g" wp-config.php
perl -pi -e "s/password_here/$dbpass/g" wp-config.php

#set WP salts
perl -i -pe'
  BEGIN {
    @chars = ("a" .. "z", "A" .. "Z", 0 .. 9);
    push @chars, split //, "!@#$%^&*()-_ []{}<>~\`+=,.;:/?|";
    sub salt { join "", map $chars[ rand @chars ], 1 .. 64 }
  }
  s/put your unique phrase here/salt()/ge
' wp-config.php

#create uploads folder and set permissions
mysql -u root <<-EOF
ALTER USER 'root'@'localhost' IDENTIFIED WITH mysql_native_password BY '$dbroot';
DELETE FROM mysql.user WHERE User='root' AND Host NOT IN ('localhost', '127.0.0.1', '::1');
DELETE FROM mysql.user WHERE User='';
DELETE FROM mysql.db WHERE Db='test' OR Db='test_%';
FLUSH PRIVILEGES;
create database $dbname;
CREATE USER '$dbuser' @'localhost' IDENTIFIED BY '$dbpass';
GRANT ALL PRIVILEGES ON $dbname.* TO '$dbuser'@'localhost' IDENTIFIED BY '$dbpass';
FLUSH PRIVILEGES;
exit
EOF
cd /etc/apache2/sites-available
echo >> wordpress.conf

echo "============================================"
echo "Set Domain Name or IP Address:"
echo "============================================"

echo "Domain Name / IP address: "
read -e dname

cat > wordpress.conf << EOF1
<VirtualHost *:80>

ServerAdmin localhost
ServerName $dname
DocumentRoot /var/www/html/wordpress

<Directory /var/www/html/wordpress>
     Options Indexes FollowSymLinks
     AllowOverride All
     Require all granted
</Directory>

ErrorLog ${APACHE_LOG_DIR}/your_domain.com_error.log 
CustomLog ${APACHE_LOG_DIR}/your_domain.com_access.log combined 
</VirtualHost>
EOF1

a2enmod rewrite
a2dissite 000-default.conf
a2ensite wordpress.conf
service apache2 restart



echo "Cleaning..."
#remove zip file

#remove bash scipt

echo "========================="
echo "Installation is complete."
echo "========================="
fi

