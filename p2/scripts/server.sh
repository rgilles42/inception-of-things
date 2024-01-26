#!/bin/bash
curl -sfL https://get.k3s.io | sh -s - server --write-kubeconfig-mode 644 --advertise-address=192.168.56.110 --node-ip=192.168.56.110
sleep 10
kubectl apply -f /vagrant/confs/deployment.yaml
kubectl wait --for=condition=Ready pods --all
