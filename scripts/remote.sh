# !/bin/sh

ssh -i ~/.ssh/rsa_server/drupal_rsa root@m.shrestharajat.com << EOL
# !/bin/sh

# these commands will run on remote vm
sudo systemctl start apache2
sudo systemctl restart apache2
EOL

