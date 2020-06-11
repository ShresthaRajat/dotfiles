#!/bin/sh

figlet "Install Docker"


figlet "removing previous docker installation"
sudo apt-get remove docker docker-engine docker.io containerd runc

figlet "updating ..."
sudo apt-get update

figlet "Installing dependencies"
declare -a programs=("curl" "apt-transport-https" "ca-certificates" "curl" "gnupg-agent" "software-properties-common")
for p in "${programs[@]}"
do
   figlet "$p"
   sudo apt -y install $p
done

figlet "Verifing Fingerprints"
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo apt-key fingerprint 0EBFCD88
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"

sudo apt-get update
sudo apt-get -y upgrade


figlet "Installing Docker"
sudo apt-get -y install docker-ce docker-ce-cli containerd.io

figlet "SUDO Dockerr!!"
sudo groupadd docker
sudo usermod -aG docker $USER

figlet "Installed!"
sudo docker run hello-world

echo "Please run newgrp docker after relogging"