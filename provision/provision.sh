#! /bin/sh

# assume working with ubuntu16 xenial box, the user will be 'ubuntu'
_USER="ubuntu"
_GROUP="ubuntu"

# insert ssh keys
# if this doesn't work, run the script in /vagrant/shared on each machine
if [ -e /home/$_USER/.ssh/ ]; then
  echo "[provision] /home/$_USER/.ssh/ already exists."
else
  sudo mkdir /home/$_USER/.ssh
  echo "[provision] /home/$_USER/.ssh/ created."
fi

sudo cp /tmp/id_rsa /home/$_USER/.ssh/id_rsa
sudo cat /tmp/id_rsa.pub >> /home/$_USER/.ssh/authorized_keys
sudo chown $_USER:$_GROUP /home/$_USER/.ssh/id_rsa
sudo chown $_USER:$_GROUP /home/$_USER/.ssh/authorized_keys
sudo chmod 400 /home/$_USER/.ssh/id_rsa
echo "[provision] customized SSH key installed."

# hosts
if [ -e /tmp/hosts_updated ]; then
  echo "hosts file already updated"
else
  sudo sed -i '$a \
192.168.100.100 master \
192.168.100.101 data1 \
192.168.100.102 data2 \
192.168.100.103 data3' /etc/hosts
  sudo touch /tmp/hosts_updated
  echo "[provision] hosts file updated."
fi

# apt
if [ -e /etc/apt/sources.list ]; then
  sudo mv /etc/apt/sources.list /etc/apt/sources.list.bak
fi
sudo cp /tmp/sources.list /etc/apt/sources.list
sudo apt update

# root privilege
sudo usermod -G sudo $_USER
echo "[provision] user $_USER added to sudo group."
