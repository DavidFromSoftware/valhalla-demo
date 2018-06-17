#!/usr/bin/env sh

# sleep timer for packer
sleep 30

# add additional repos
add-apt-repository "deb http://archive.ubuntu.com/ubuntu $(lsb_release -sc) main universe"
add-apt-repository "deb http://archive.ubuntu.com/ubuntu $(lsb_release -sc)-updates main universe"

# update, install curl and linux kernel 3.16
apt-get update --fix-missing
apt-get upgrade -y
apt-get install -y curl linux-headers-3.16.0-29 linux-headers-3.16.0-29-generic \
                   linux-image-3.16.0-29-generic linux-image-extra-3.16.0-29-generic

apt-key adv --keyserver hkp://p80.pool.sks-keyservers.net:80 --recv-keys 58118E89F3A912897C070ADBF76221572C52609D
apt-add-repository 'deb https://apt.dockerproject.org/repo ubuntu-xenial main'
apt-get update
apt-cache policy docker-engine
apt-get install -y docker-engine
systemctl status docker