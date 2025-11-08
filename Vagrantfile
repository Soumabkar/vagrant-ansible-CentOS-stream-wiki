Vagrant.configure("2") do |config|

  config.vm.define "master" do |master|

    master.vm.box = "generic/centos9s"
    master.vm.network "private_network", ip: "192.168.56.10"

    master.vm.provider "virtualbox" do |vb|
      vb.memory = "2048"  # Allouer 2 Go de RAM
    end

    master.vm.provision "shell", path: "provision_master.sh"
    master.vm.provision "file", source: "install-apache-restart-by-handler.yml", destination: "/home/vagrant/ansible/install-apache-restart-by-handler.yml"
    master.vm.provision "file", source: "inventaire-apache.yml", destination: "/home/vagrant/ansible/inventaire-apache.yml"
    master.vm.provision "shell", inline: <<-SHELL
        sudo echo "192.168.56.11	worker" | sudo tee -a /etc/hosts
    SHELL

  end

  config.vm.define "worker" do |worker|

    worker.vm.box = "generic/centos9s"
    worker.vm.network "private_network", ip: "192.168.56.11"

    worker.vm.provider "virtualbox" do |vb|
      vb.memory = "2048"  # Allouer 2 Go de RAM
    end

    worker.vm.provision "file", source: "master_id_rsa.pub", destination: "/home/vagrant/ansible/master_id_rsa.pub"
    worker.vm.provision "shell", path: "add_master_key_to_node_authorized_keys.sh"
    worker.vm.provision "shell", path: "configure_sshd.sh"

  end

end
