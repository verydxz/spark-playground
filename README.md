# Playground to get familiar with distributed data systems

## Virtual Machines
* Install `Vagrant`
* Edit `Vagrantfile` where variable `the_box` is the VM you choose (currently only `ubuntu` is supported. In GFW, you can download and `vagrent box add` [Ubuntu 16.04 Xenial](https://cloud-images.ubuntu.com/xenial/current/) in advance)
* `vagrant up`
  * 4 VMs will be up: `master`, `data1`, `data2`, `data3`, see the `Vagrantfile` for details (please note a host memory of **>= 16GB** is recommended)
  * each VM has a dedicated synced folder `/vagrant/local` mapped to `synced_folders/<machine>` on the host, and another folder `/vagrant/shared` is accessible to all (this is useful so we can share one set of runtime & config files in `shared`, but then configure the same paths for data & logs to `local`)
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

## [Hadoop Setup](docs/hadoop-setup.md)

## [Hive Setup](docs/hive-setup.md)

## [Impala Setup](docs/impala-setup.md)

## [Spark Setup](docs/spark-setup.md)
