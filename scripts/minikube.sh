#!/bin/sh


# Install minikube
# Requires docker to be installed
curl -LO https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64
sudo install minikube-linux-amd64 /usr/local/bin/minikube
rm -rf minikube-linux-amd64

# Install kubectl
sudo install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl


# minikube commands
minikube start
minikube dashboard

# kubectl commands
kubectl version
kubectl cluster-info