#! /bin/bash

# ssh key - some how below doesn't work...
# use the script in /vagrant/shared on each machine
cp /tmp/id_rsa ~/.ssh/id_rsa
chmod 400 ~/.ssh/id_rsa
cat /tmp/id_rsa.pub >> ~/.ssh/authorized_keys

# apt-get
sudo mv /etc/apt/sources.list /etc/apt/sources.list.bak
sudo cp /tmp/sources.list /etc/apt/sources.list
sudo apt-get update

# hosts
sudo echo "192.168.100.100 master" >> /etc/hosts
sudo echo "192.168.100.101 data1" >> /etc/hosts
sudo echo "192.168.100.102 data2" >> /etc/hosts
