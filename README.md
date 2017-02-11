# Playground to test out distributed system

## Setup
* Install `Vagrant`
* `vagrant up`
    * 3 machines will be up: `master`, `data1`, `data2`
    * each machine has synced folders in /vagrant
    * `vagrant ssh <machine_name>` and run `/vagrant/shared/init-ssh-key.sh` (some how the provision doesn't work, this is a walk-around)

## Usage
* `vagrant ssh <machine_name>`
* `vagrant suspend` & `vagrant resume`
* `vagrant halt` & `vagrant up`
* and `vagrant destroy`
