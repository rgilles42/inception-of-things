#!/bin/bash
set -e

echo [1/3] Creating cluster...
k3d cluster create iot-p3 -p 8080:80@loadbalancer

echo [2/3] Deploying ArgoCD
kubectl create namespace argocd
curl -fsSL https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml -o argo_install.yaml
sed -i '/- \/usr\/local\/bin\/argocd-server/a \ \ \ \ \ \ \ \ - --insecure' argo_install.yaml
sed -i '/^\ \ name: argocd-cm$/a data:\n\ \ timeout.reconciliation: 5s' argo_install.yaml
kubectl apply -n argocd -f argo_install.yaml
sleep 30

echo [3/3] Ensuring launch and Deploying ArgoCD Ingress
kubectl wait --for=condition=Ready pods --all -n argocd --timeout -1s
rm -f argo_install.yaml
kubectl apply -f confs/ingress_argocd.yaml

ARGOPW=$(kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath={.data.password} | base64 -d)
echo "The ArgoCD 'admin' password is '$ARGOPW'."


