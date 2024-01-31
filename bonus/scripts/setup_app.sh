#!/bin/bash

kubectl create namespace dev
kubectl apply -n argocd -f confs/argocd/application.yaml
