Vagrant.configure("2") do |config|
  config.omnibus.chef_version = "11.6.0"
  config.vm.hostname = "kafka-berkshelf"
  config.vm.box = "Berkshelf-CentOS-6.3-x86_64-minimal"
  config.vm.box_url = "https://dl.dropbox.com/u/31081437/Berkshelf-CentOS-6.3-x86_64-minimal.box"
  config.vm.network :private_network, ip: "33.33.33.11"
  config.berkshelf.enabled = true
  config.vm.provision :chef_solo do |chef|
    # chef.log_level = :debug
    chef.json = {
      build_essential: { compiletime: true }
    }
    chef.run_list = [
      "recipe[kafka::_test_zookeeper]",
      "recipe[kafka::default]"
    ]
  end
end
