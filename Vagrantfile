# -*- mode: ruby -*-
# vi: set ft=ruby :

`git submodule init`
`git submodule update`

#############################################
# Sample setup script:
# require 'ostruct'

# USER_CONFIG = OpenStruct.new({
#  data_dir: "#{ File.expand_path '~' }/vagrant_data",
# });
#############################################

if File.file?(File.expand_path '~/vagrant_setup.rb')
  require '~/vagrant_setup.rb'
else
  require 'ostruct'
  USER_CONFIG = OpenStruct.new(data_dir: (File.expand_path '~'))
end

Vagrant.configure("2") do |config|
  # All Vagrant configuration is done here. The most common configuration
  # options are documented and commented below. For a complete reference,
  # please see the online documentation at vagrantup.com.

  # Every Vagrant virtual environment requires a box to build off of.
  config.vm.box = "precise64"

  # The url from where the 'config.vm.box' box will be fetched if it
  # doesn't already exist on the user's system.
  config.vm.box_url = "http://files.vagrantup.com/precise64.box"

  # Create a forwarded port mapping which allows access to a specific port
  # within the machine from a port on the host machine. In the example below,
  # accessing "localhost:8080" will access port 80 on the guest machine.
  config.vm.network :forwarded_port, guest: 3000, host: 3030

  # Create a private network, which allows host-only access to the machine
  # using a specific IP.
  # config.vm.network :private_network, ip: "192.168.33.10"
  config.vm.network :private_network, ip: "192.168.50.2"

  # Run apt-get update every 30 days
  config.vm.provision :shell, :inline => %Q{
    cd ~
    updated_in_30=`find ./ -type f -mtime -30 -name .apt-get-updated`

    if [ "$updated_in_30" = "" ]; then
      sudo /usr/bin/apt-get update
      touch ~/.apt-get-updated
    fi
  }

  # Provision the machine and perform all configuration
  config.vm.provision :puppet do |puppet|
    puppet.options = "--verbose --debug"
    puppet.manifests_path = "manifests"
    puppet.manifest_file  = "base.pp"
    puppet.module_path = 'modules'
  end

  # Share an additional folder to the guest VM. The first argument is
  # the path on the host to the actual folder. The second argument is
  # the path on the guest to mount the folder. And the optional third
  # argument is a set of non-required options.

  # TODO: figure out why NFS sharing isn't working for a home-dir-based
  #       folder
  if USER_CONFIG.data_dir
    config.vm.synced_folder USER_CONFIG.data_dir, "/host_folder"
  end
end
