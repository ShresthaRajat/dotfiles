#!/bin/sh


# Install minikube
# Requires docker to be installed
curl -LO https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64
sudo install minikube-linux-amd64 /usr/local/bin/minikube
rm -rf minikube-linux-amd64

# Install kubectl
sudo install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl


# minikube commands

# basic info
minikube version
minikube status
minikube ip
minikube addons list
minikube dashboard

# cluster(container) create/stop/destroy
minikube start
minikube stop
minikube delete

# enable/view/disable addons
minikube addons enable ingress
minikube addons enable dashboard
minikube addons enable metrics-server
minikube addons disable ingress
minikube addons list
minikube addons list | grep STATUS && minikube addons list | grep enabled

# use minikube kubectl
minikube kubectl
minikube kubectl -- get pods -At

# get 
minikube service hello-minikube1 --url
minikube service hello-minikube1 -n demo --url 

# tunnel creation
minikube tunnel
