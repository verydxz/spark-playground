#! /bin/bash

# apt-get
sudo mv /etc/apt/sources.list /etc/apt/sources.list.bak
sudo mv /tmp/sources.list /etc/apt/sources.list
sudo apt-get update
