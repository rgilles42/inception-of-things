#!/bin/bash

echo [1/5] Installing required dependencies
sudo apt-get update
sudo apt-get install -y ca-certificates curl gnupg

echo [2/5] Adding Docker repository GPG key to APT keyring
sudo install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/debian/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
sudo chmod a+r /etc/apt/keyrings/docker.gpg

echo [3/5] Adding Docker repository to APT sources
echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/debian $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update

echo [4/5] Installing Docker packages
sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

echo [5/5] Creating docker group and adding $USER
sudo groupadd docker
sudo usermod -aG docker $USER

echo
echo Docker has been succesfully installed and user $USER has been added to the docker group.
echo Please relog in order to refresh your groups and use docker without root privileges.
echo Alternatively, you can run \`newgrp docker\`.
