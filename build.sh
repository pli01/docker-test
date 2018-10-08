#!/bin/bash

apt-get -qqy update && \
    apt-get install -qy make apt-transport-https ca-certificates curl software-properties-common gawk jq parallel sudo vim

useradd -m debian
usermod -aG sudo debian
echo "debian ALL=NOPASSWD: ALL" >> /etc/sudoers

curl -fsSL https://download.docker.com/linux/debian/gpg | sudo apt-key add -
add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/debian $(lsb_release -cs) stable"
apt-get -qy update
apt-get -qy install docker-ce --allow-unauthenticated

# Fix perm
/bin/chmod -v a+s $(which docker)

usermod -aG docker debian

docker version

DOCKER_COMPOSE_VERSION=1.19.0
rm -rf /usr/local/bin/docker-compose
curl -L https://github.com/docker/compose/releases/download/${DOCKER_COMPOSE_VERSION}/docker-compose-`uname -s`-`uname -m` > docker-compose
chmod +x docker-compose
mv docker-compose /usr/local/bin/
 
docker-compose version

# clean
apt-get -qqy clean && \
    apt-get autoremove && \
    rm -rf /var/lib/apt/lists/*
