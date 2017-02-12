#! /bin/bash

cp /tmp/id_rsa ~/.ssh/id_rsa
chmod 400 ~/.ssh/id_rsa
cat /tmp/id_rsa.pub >> ~/.ssh/authorized_keys
