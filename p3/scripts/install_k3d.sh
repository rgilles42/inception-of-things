#!/bin/bash

# Docker is already installed

# Install kubectl
echo [1/3] Downloading kubectl
curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
echo [2/3] Installing kubectl
sudo install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl && rm -f kubectl

# Install k3d
echo [3/3] Executing k3d install script
curl -s https://raw.githubusercontent.com/k3d-io/k3d/main/install.sh | sudo bash

