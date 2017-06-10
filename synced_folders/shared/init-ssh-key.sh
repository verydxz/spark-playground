#! /bin/sh

if [ -e ~/.ssh/ ]; then
  echo "~/.ssh/ already exists."
else
  mkdir ~/.ssh
  echo "~/.ssh/ created."
fi
cp /tmp/id_rsa ~/.ssh/id_rsa
chmod 400 ~/.ssh/id_rsa
cat /tmp/id_rsa.pub >> ~/.ssh/authorized_keys
