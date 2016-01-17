# -*- mode: ruby -*-
# vi: set ft=ruby :

VAGRANTFILE_API_VERSION = "2"
Vagrant.require_version ">= 1.7.4"
domain = "vagrant"
web_ports = [{ :host_port => 8484, :guest_port => 8484 }]

vagrant_nodes_conf = [
   { :ip => "192.168.56.11", :host => 'web01', :mem => '512', :role => 'web', :forwarded_port => web_ports },
   { :ip => "192.168.56.12", :host => 'app01', :mem => '512', :role => 'app' },
   { :ip => "192.168.56.13", :host => 'app02', :mem => '512', :role => 'app' }
]

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|

  config.vm.box = "bento/centos-6.7"

  config.vm.provider :virtualbox do |virtualbox|
    virtualbox.customize ["modifyvm", :id, "--groups", "/tasssko"]
  end

  # Set up each of the puppet vagrant_nodes_conf
  vagrant_nodes_conf.each do |vagrant_agent_conf|

    config.vm.define vagrant_agent_conf[:host].to_sym do |chef_agent|

      chef_agent.vm.hostname = "#{vagrant_agent_conf[:host]}.#{domain}"
      chef_agent.vm.network :private_network, ip: vagrant_agent_conf[:ip]

        if ! vagrant_agent_conf[:forwarded_port].nil?
          vagrant_agent_conf[:forwarded_port].each do |port|
            chef_agent.vm.network "forwarded_port", guest: port[:guest_port], host: port[:host_port]
          end
        end

      chef_agent.vm.provider :virtualbox do |virtualbox|
        virtualbox.customize ["modifyvm", :id, "--memory", vagrant_agent_conf[:mem]]
        virtualbox.name = "#{vagrant_agent_conf[:host]}.#{domain}"
      end

      config.vm.provision "chef_zero" do |chef|
        chef.cookbooks_path = "cookbooks"
        chef.environments_path = "environments"
        chef.nodes_path = "nodes"
        chef.roles_path = "roles"
        chef.add_role "#{vagrant_agent_conf[:role]}"
      end

    end
  end
end
