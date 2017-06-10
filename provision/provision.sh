#! /bin/sh

# assume working with ubuntu16 xenial box, the user will be 'ubuntu'
USERHOME="/home/ubuntu"

# insert ssh keys
# if this doesn't work, run the script in /vagrant/shared on each machine
if [ -e $USERHOME/.ssh/ ]; then
  echo "$USERHOME/.ssh/ already exists."
else
  mkdir $USERHOME/.ssh
  echo "$USERHOME/.ssh/ created."
fi
cp /tmp/id_rsa $USERHOME/.ssh/id_rsa
chmod 400 $USERHOME/.ssh/id_rsa
cat /tmp/id_rsa.pub >> $USERHOME/.ssh/authorized_keys

# apt
if [ -e /etc/apt/sources.list ]; then
  sudo mv /etc/apt/sources.list /etc/apt/sources.list.bak
fi
sudo cp /tmp/sources.list /etc/apt/sources.list
sudo apt update

# hosts
sudo sed -i '$a \
192.168.100.100 master \
192.168.100.101 data1 \
192.168.100.102 data2 \
192.168.100.103 data3' /etc/hosts
