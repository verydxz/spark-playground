#! /bin/sh

# assume working with ubuntu16 xenial box, the user will be 'ubuntu'
_USER="ubuntu"
_GROUP="ubuntu"

# insert ssh keys
# if this doesn't work, run the script in /vagrant/shared on each machine
if [ -e /home/$_USER/.ssh/ ]; then
  echo "/home/$_USER/.ssh/ already exists."
else
  mkdir /home/$_USER/.ssh
  echo "/home/$_USER/.ssh/ created."
fi

cp /tmp/id_rsa /home/$_USER/.ssh/id_rsa
cat /tmp/id_rsa.pub >> /home/$_USER/.ssh/authorized_keys
chown $_USER:$_GROUP /home/$_USER/.ssh/id_rsa
chown $_USER:$_GROUP /home/$_USER/.ssh/authorized_keys
chmod 400 /home/$_USER/.ssh/id_rsa
echo "SSH key installed."

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
