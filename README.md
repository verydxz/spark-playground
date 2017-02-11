# Playground to test out distributed system

## Setup
* Install `Vagrant`
* `vagrant up`
    * 3 machines will be up: `master`, `data1`, `data2`
    * each machine has a dedicated synced folder `/vagrant/local`, and `/vagrant/shared` is shared across all
    * `vagrant ssh <machine_name>` to each, and run `/vagrant/shared/init-ssh-key.sh` (some how my provision doesn't work, this is a walk-around)

## Usage
* `vagrant ssh <machine_name>`
* `vagrant suspend` & `vagrant resume`
* `vagrant halt` & `vagrant up`
* and `vagrant destroy`
