#!/bin/bash
set -e

echo [1/5] Creating cluster...
k3d cluster create iot-bonus -p 8080:80@loadbalancer

echo [2/5] Deploying ArgoCD
kubectl create namespace argocd
curl -fsSL https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml -o argo_install.yaml
sed -i '/- \/usr\/local\/bin\/argocd-server/a \ \ \ \ \ \ \ \ - --insecure' argo_install.yaml
sed -i '/^\ \ name: argocd-cm$/a data:\n\ \ timeout.reconciliation: 5s' argo_install.yaml
kubectl apply -n argocd -f argo_install.yaml
sleep 30

echo [3/5] Ensuring launch and Deploying ArgoCD Ingress
kubectl wait --for=condition=Ready pods --all -n argocd --timeout -1s
rm -f argo_install.yaml
kubectl apply -n argocd -f confs/argocd/ingress.yaml

echo [4/5] Deploying GitLab
kubectl create namespace gitlab
kubectl apply -n gitlab -f confs/gitlab/deployment.yaml
sleep 5

echo [5/5] Ensuring launch and Deploying GitLab Ingress
kubectl wait --for=condition=Ready pods --all -n gitlab --timeout -1s
kubectl apply -n gitlab -f confs/gitlab/ingress.yaml

ARGOPW=$(kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath={.data.password} | base64 -d)
echo "The ArgoCD 'admin' password is '$ARGOPW'."
GITLABPW=$(kubectl exec -n gitlab $(kubectl get pods -n gitlab -o name) -- cat /etc/gitlab/initial_root_password)
echo "The GitLab initial root password is '$GITLABPW'."


