Vagrant.configure("2") do |config|

  config.vbguest.auto_update = false


  config.vm.define "master" do |master|

    master.vm.box = "generic/centos9s"
    master.vm.network "private_network", ip: "192.168.56.10"

    master.vm.provider "virtualbox" do |vb|
      vb.memory = "2048"  # Allouer 2 Go de RAM
    end

    master.vm.provision "shell", path: "provision_master.sh"


    master.vm.provision "file", source: "install-apache-restart-by-handler.yml", destination: "/home/vagrant/ansible/install-apache-restart-by-handler.yml"
    master.vm.provision "file", source: "inventaire-apache.yml", destination: "/home/vagrant/ansible/inventaire-apache.yml"
    master.vm.provision "file", source: "inventory.conf.j2", destination: "/home/vagrant/ansible/inventory.conf.j2" 


    master.vm.provision "file", source: "install-apache.yml", destination: "/home/vagrant/ansible/playbooks/install-apache.yml"
    master.vm.provision "file", source: "install-inventaire.yml", destination: "/home/vagrant/ansible/playbooks/install-inventaire.yml"
    master.vm.provision "file", source: "install-mariadb.yml", destination: "/home/vagrant/ansible/playbooks/install-mariadb.yml"
    master.vm.provision "file", source: "install-mediawiki.yml", destination: "/home/vagrant/ansible/playbooks/install-mediawiki.yml"
    master.vm.provision "file", source: "inventaire-apache.yml", destination: "/home/vagrant/ansible/playbooks/inventaire-apache.yml"
    master.vm.provision "file", source: "inventaire.yml", destination: "/home/vagrant/ansible/playbooks/inventaire.yml"
    master.vm.provision "file", source: "machine.html.j2", destination: "/home/vagrant/ansible/playbooks/machine.html.j2"
    master.vm.provision "file", source: "multi-conf-apache.yml", destination: "/home/vagrant/ansible/playbooks/multi-conf-apache.yml"
    master.vm.provision "file", source: "multi-include.yml", destination: "/home/vagrant/ansible/playbooks/multi-include.yml"
    master.vm.provision "file", source: "wiki.yml", destination: "/home/vagrant/ansible/playbooks/wiki.yml"
    master.vm.provision "file", source: "set-seboolean.yml", destination: "/home/vagrant/ansible/playbooks/set-seboolean.yml"


    master.vm.provision "file", source: "playbooks/roles/apache/defaults/main.yml", destination: "/home/vagrant/ansible/playbooks/roles/apache/defaults/main.yml"
    master.vm.provision "file", source: "playbooks/roles/apache/handlers/main.yml", destination: "/home/vagrant/ansible/playbooks/roles/apache/handlers/main.yml"
    master.vm.provision "file", source: "playbooks/roles/apache/tasks/main.yml", destination: "/home/vagrant/ansible/playbooks/roles/apache/tasks/main.yml"
    master.vm.provision "file", source: "playbooks/roles/apache/tasks/php-install.yml", destination: "/home/vagrant/ansible/playbooks/roles/apache/tasks/php-install.yml"
    master.vm.provision "file", source: "playbooks/roles/apache/vars/main.yml", destination: "/home/vagrant/ansible/playbooks/roles/apache/vars/main.yml"


    master.vm.provision "file", source: "playbooks/roles/apache-inventory/defaults/main.yml", destination: "/home/vagrant/ansible/playbooks/roles/apache-inventory/defaults/main.yml"
    master.vm.provision "file", source: "playbooks/roles/apache-inventory/meta/main.yml", destination: "/home/vagrant/ansible/playbooks/roles/apache-inventory/meta/main.yml"
    master.vm.provision "file", source: "playbooks/roles/apache-inventory/tasks/main.yml", destination: "/home/vagrant/ansible/playbooks/roles/apache-inventory/tasks/main.yml"
    master.vm.provision "file", source: "playbooks/roles/apache-inventory/templates/inventaire.conf.j2", destination: "/home/vagrant/ansible/playbooks/roles/apache-inventory/templates/inventaire.conf.j2"


    master.vm.provision "file", source: "playbooks/roles/mariadb/handlers/main.yml", destination: "/home/vagrant/ansible/playbooks/roles/mariadb/handlers/main.yml"
    master.vm.provision "file", source: "playbooks/roles/mariadb/tasks/main.yml", destination: "/home/vagrant/ansible/playbooks/roles/mariadb/tasks/main.yml"

 
    master.vm.provision "file", source: "playbooks/roles/mediawiki/common/defaults/main.yml", destination: "/home/vagrant/ansible/playbooks/roles/mediawiki/common/defaults/main.yml"
    master.vm.provision "file", source: "playbooks/roles/mediawiki/configuration/defaults/main.yml", destination: "/home/vagrant/ansible/playbooks/roles/mediawiki/configuration/defaults/main.yml"
    master.vm.provision "file", source: "playbooks/roles/mediawiki/configuration/meta/main.yml", destination: "/home/vagrant/ansible/playbooks/roles/mediawiki/configuration/meta/main.yml"


    master.vm.provision "file", source: "playbooks/roles/mediawiki/mariadb/meta/main.yml", destination: "/home/vagrant/ansible/playbooks/roles/mediawiki/mariadb/meta/main.yml"
    master.vm.provision "file", source: "playbooks/roles/mediawiki/mariadb/tasks/main.yml", destination: "/home/vagrant/ansible/playbooks/roles/mediawiki/mariadb/tasks/main.yml"


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

config.vm.define "apache1" do |apache1|

    apache1.vm.box = "generic/centos9s"
    apache1.vm.network "private_network", ip: "192.168.56.12"

    apache1.vm.provider "virtualbox" do |vb|
      vb.memory = "2048"  # Allouer 2 Go de RAM
    end

    apache1.vm.provision "file", source: "master_id_rsa.pub", destination: "/home/vagrant/ansible/master_id_rsa.pub"
    apache1.vm.provision "shell", path: "add_master_key_to_node_authorized_keys.sh"
    apache1.vm.provision "shell", path: "configure_sshd.sh"

  end

config.vm.define "mysql1" do |mysql1|

    mysql1.vm.box = "generic/centos9s"
    mysql1.vm.network "private_network", ip: "192.168.56.13"

    mysql1.vm.provider "virtualbox" do |vb|
      vb.memory = "2048"  # Allouer 2 Go de RAM
    end

    mysql1.vm.provision "file", source: "master_id_rsa.pub", destination: "/home/vagrant/ansible/master_id_rsa.pub"
    mysql1.vm.provision "shell", path: "add_master_key_to_node_authorized_keys.sh"
    mysql1.vm.provision "shell", path: "configure_sshd.sh"

  end

end
