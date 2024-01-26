#!/bin/bash

echo [1/3] Adding Vagrant repository GPG key to APT keyring
sudo install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://apt.releases.hashicorp.com/gpg | sudo gpg --dearmor -o /usr/share/keyrings/hashicorp-archive-keyring.gpg
sudo chmod a+r /usr/share/keyrings/hashicorp-archive-keyring.gpg

echo [2/3] Adding Vagrant repository to APT sources
echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/hashicorp.list
sudo apt-get update

echo [3/4] Installing Vagrant
sudo apt-get install -y vagrant

