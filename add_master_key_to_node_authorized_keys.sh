#!/bin/bash
sudo mkdir -p /home/vagrant/.ssh
sudo chmod 700 /home/vagrant/.ssh
sudo touch /home/vagrant/.ssh/authorized_keys
sudo chmod 600 /home/vagrant/.ssh/authorized_keys
sudo cat /home/vagrant/ansible/master_id_rsa.pub | sudo tee -a /home/vagrant/.ssh/authorized_keys
sudo echo "192.168.56.10	master" | sudo tee -a /etc/hosts
