# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.require_version ">= 1.9.0", "< 2.0.0"

# All Vagrant configuration is done below. The "2" in Vagrant.configure
# configures the configuration version (we support older styles for
# backwards compatibility). Please don't change it unless you know what
# you're doing.
Vagrant.configure("2") do |config|
  # The most common configuration options are documented and commented below.
  # For a complete reference, please see the online documentation at
  # https://docs.vagrantup.com.

  # Every Vagrant development environment requires a box. You can search for
  # boxes at https://atlas.hashicorp.com/search.

  # files for setting & provision
  config.vm.provision "file", source: "provision/files/sources.list", destination: "/tmp/sources.list"
  config.vm.provision "file", source: "provision/files/id_rsa", destination: "/tmp/id_rsa"
  config.vm.provision "file", source: "provision/files/id_rsa.pub", destination: "/tmp/id_rsa.pub"

  # from https://github.com/laravel/homestead/blob/master/scripts/homestead.rb
  # Prevent TTY Errors
  config.ssh.shell = "bash -c 'BASH_ENV=/etc/profile exec bash'"

  # base provision for all machines
  config.vm.provision "shell", path: "provision/provision.sh"

  # config.vm.box = "xenial"
  the_box = "xenial"

  config.vm.define "master" do |machine|
    machine.vm.box = the_box
    machine.vm.network "private_network", ip: "192.168.100.100"
    machine.vm.provision "shell", inline: "sudo echo master > /etc/hostname"
    machine.vm.provision "shell", inline: "sudo hostname master"
    machine.vm.synced_folder ".", "/vagrant/", disabled: true
    machine.vm.synced_folder "synced_folders/master/", "/vagrant/local/", create: true
    machine.vm.synced_folder "synced_folders/shared/", "/vagrant/shared/", create: true
    machine.vm.provider "virtualbox" do |v|
      v.name = "master"
      v.memory = 4096
      v.cpus = 2
    end
  end

  config.vm.define "data1" do |machine|
    machine.vm.box = the_box
    machine.vm.network "private_network", ip: "192.168.100.101"
    machine.vm.provision "shell", inline: "sudo echo data1 > /etc/hostname"
    machine.vm.provision "shell", inline: "sudo hostname data1"
    machine.vm.synced_folder ".", "/vagrant/", disabled: true
    machine.vm.synced_folder "synced_folders/data1/", "/vagrant/local/", create: true
    machine.vm.synced_folder "synced_folders/shared/", "/vagrant/shared/", create: true
    machine.vm.provider "virtualbox" do |v|
      v.name = "data1"
      v.memory = 2048
      v.cpus = 1
    end
  end

  config.vm.define "data2" do |machine|
    machine.vm.box = the_box
    machine.vm.network "private_network", ip: "192.168.100.102"
    machine.vm.provision "shell", inline: "sudo echo data2 > /etc/hostname"
    machine.vm.provision "shell", inline: "sudo hostname data2"
    machine.vm.synced_folder ".", "/vagrant/", disabled: true
    machine.vm.synced_folder "synced_folders/data2/", "/vagrant/local/", create: true
    machine.vm.synced_folder "synced_folders/shared/", "/vagrant/shared/", create: true
    machine.vm.provider "virtualbox" do |v|
      v.name = "data2"
      v.memory = 2048
      v.cpus = 1
    end
  end

    config.vm.define "data3" do |machine|
      machine.vm.box = the_box
      machine.vm.network "private_network", ip: "192.168.100.103"
      machine.vm.provision "shell", inline: "sudo echo data3 > /etc/hostname"
      machine.vm.provision "shell", inline: "sudo hostname data3"
      machine.vm.synced_folder ".", "/vagrant/", disabled: true
      machine.vm.synced_folder "synced_folders/data3/", "/vagrant/local/", create: true
      machine.vm.synced_folder "synced_folders/shared/", "/vagrant/shared/", create: true
      machine.vm.provider "virtualbox" do |v|
        v.name = "data3"
        v.memory = 2048
        v.cpus = 1
      end
  end

  # Disable automatic box update checking. If you disable this, then
  # boxes will only be checked for updates when the user runs
  # `vagrant box outdated`. This is not recommended.
  # config.vm.box_check_update = false

  # Create a forwarded port mapping which allows access to a specific port
  # within the machine from a port on the host machine. In the example below,
  # accessing "localhost:8080" will access port 80 on the guest machine.
  # config.vm.network "forwarded_port", guest: 80, host: 8080

  # Create a private network, which allows host-only access to the machine
  # using a specific IP.
  # config.vm.network "private_network", ip: "192.168.33.10"

  # Create a public network, which generally matched to bridged network.
  # Bridged networks make the machine appear as another physical device on
  # your network.
  # config.vm.network "public_network"

  # Share an additional folder to the guest VM. The first argument is
  # the path on the host to the actual folder. The second argument is
  # the path on the guest to mount the folder. And the optional third
  # argument is a set of non-required options.
  # config.vm.synced_folder "../data", "/vagrant_data"

  # Provider-specific configuration so you can fine-tune various
  # backing providers for Vagrant. These expose provider-specific options.
  # Example for VirtualBox:
  #
  # config.vm.provider "virtualbox" do |vb|
  #   # Display the VirtualBox GUI when booting the machine
  #   vb.gui = true
  #
  #   # Customize the amount of memory on the VM:
  #   vb.memory = "1024"
  # end
  #
  # View the documentation for the provider you are using for more
  # information on available options.

  # Define a Vagrant Push strategy for pushing to Atlas. Other push strategies
  # such as FTP and Heroku are also available. See the documentation at
  # https://docs.vagrantup.com/v2/push/atlas.html for more information.
  # config.push.define "atlas" do |push|
  #   push.app = "YOUR_ATLAS_USERNAME/YOUR_APPLICATION_NAME"
  # end

  # Enable provisioning with a shell script. Additional provisioners such as
  # Puppet, Chef, Ansible, Salt, and Docker are also available. Please see the
  # documentation for more information about their specific syntax and use.
  # config.vm.provision "shell", inline: <<-SHELL
  #   apt-get update
  #   apt-get install -y apache2
  # SHELL
end
