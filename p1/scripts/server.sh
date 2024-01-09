mkdir -p ~/.ssh
cat /tmp/id_rsa.pub >> ~/.ssh/authorized_keys
chmod -R 400 ~/.ssh
