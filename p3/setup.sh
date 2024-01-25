k3d cluster create iot-p3 -p 8080:80@loadbalancer -p 4443:443@loadbalancer
kubectl create namespace argocd
curl -fsSL https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml -o argo_install.yaml
sed -i '/- \/usr\/local\/bin\/argocd-server/a \ \ \ \ \ \ \ \ - --insecure' argo_install.yaml
kubectl apply -n argocd -f argo_install.yaml
rm -f argo_install.yaml
ARGOPW=$(kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath={.data.password} | base64 -d)
kubectl apply -f ingress.yaml


