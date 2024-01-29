FROM alpine:latest

RUN apk update && apk add curl bash openssh sudo openrc

RUN mkdir -p /run/openrc && touch /run/openrc/softlevel
RUN rc-status

RUN ssh-keygen -A
RUN sed -i s/^#PasswordAuthentication\ yes/PasswordAuthentication\ no/ /etc/ssh/sshd_config


RUN adduser --disabled-password vagrant
RUN passwd -u vagrant
RUN echo 'alias k=kubectl' >> /home/vagrant/.profile
RUN echo 'vagrant ALL = NOPASSWD: ALL' > /etc/sudoers.d/vagrant
RUN chmod 440 /etc/sudoers.d/vagrant

RUN mkdir -p /home/vagrant/.ssh
RUN chmod 700 /home/vagrant/.ssh
ADD https://raw.githubusercontent.com/hashicorp/vagrant/master/keys/vagrant.pub /home/vagrant/.ssh/authorized_keys
RUN chmod 600 /home/vagrant/.ssh/authorized_keys
RUN chown -R vagrant:vagrant /home/vagrant/.ssh

VOLUME /var/lib/kubelet
VOLUME /var/lib/rancher/k3s
VOLUME /var/lib/cni
VOLUME /var/log

EXPOSE 22

CMD ["/usr/sbin/sshd", "-D", "-e"]
