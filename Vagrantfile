Vagrant::Config.run do |config|
	config.vm.box = "lucid32"
	config.vm.forward_port 80, 4567
	config.vm.provision :chef_solo do |chef|
		chef.recipe_url = "http://files.vagrantup.com/getting_started/cookbooks.tar.gz"
		chef.add_recipe("vagrant_main")
	end
end