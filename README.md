# Playground to test out distributed system

## Virtual Machines
* Install `Vagrant`
* Edit `Vagrantfile` where variable `the_box` is the VM you choose (in GFW, I downloaded and `vagrent box add`-ed an [Ubuntu 16.04 Xenial](https://cloud-images.ubuntu.com/xenial/current/) in advance)
* `vagrant up`
  * 4 VM will be up: `master`, `data1`, `data2`, `data3`, see the `Vagrantfile` for details
  * each VM has a dedicated synced folder `/vagrant/local`, and another folder `/vagrant/shared` is accessible to all (this is useful so we can share the same runtime files in `shared`, but config the same paths for data & logs in `local`)
* Usage
  * `vagrant ssh <machine_name>`
  * `vagrant suspend` & `vagrant resume`
  * `vagrant halt` & `vagrant up`
  * and `vagrant destroy`

## Base Environment (may move to provision one day)
* Setup Java in each VM
  * `sudo apt install -y openjdk-8-jdk`
* Other useful packages, such as ...
  * `sudo apt install -y htop tmux git tig`

## [Hadoop Setup](docs/hadoop-setup.md)

## [Hive Setup](docs/hive-setup.md)

## [Impala Setup]()

## [Spark Setup](docs/spark-setup.md)
