# Virtual machine configs to get you started with distributed data systems

## Virtual Machines
* Install [`Vagrant`](http://www.vagrantup.com) and `virtualbox`
* Edit `Vagrantfile` where variable `the_box` is the VM you choose (currently I only support `Ubuntu`. In GFW, you can download and `vagrent box add` [Ubuntu 16.04 Xenial](https://cloud-images.ubuntu.com/xenial/current/) in advance): `vagrant box add <ubuntu16_box_file> --name xenial`
* `vagrant up`
  * 4 VMs will be up: `master` (also as `data0`), `data1`, `data2`, `data3`, see the `Vagrantfile` for details (please note a host memory of **>= 16GB** is recommended)
  * each VM has a dedicated synced folder `/vagrant/local` mapped to `synced_folders/<machine>` on the host, and another folder `/vagrant/shared` is shared for all (this is useful so we can share one set of runtime & config files in `shared`, configure the same paths for data & logs to `local`, and result in dedicated folders)
* Usage
  * `vagrant ssh <machine>`
  * `vagrant suspend` & `vagrant resume`
  * `vagrant halt` & `vagrant up`
  * and `vagrant destroy`

## Base Environment (may move to provision one day)
* Add other machines' fingerprints to `master`
  * `vagrant ssh master`, and from `master` ssh into each of the other VM
  * and during this process you can ...
* Setup Java in each VM
  * `sudo apt install -y openjdk-8-jdk`
* Install other useful packages, such as ...
  * `sudo apt install -y htop tmux git tig`

## [Hadoop / HDFS Setup](docs/hadoop-setup.md)

## [Hive (and Yarn) Setup](docs/hive-setup.md)

## Impala Setup (target: same metastore & storage layer with Hive)

## [Spark Setup](docs/spark-setup.md)
