cat /proc/sys/kernel/random/uuid > /vagrant/server_token
curl -sfL https://get.k3s.io | sh -s - server --token-file /vagrant/server_token --write-kubeconfig-mode 644 --advertise-address=192.168.56.110 --node-ip=192.168.56.110
