#!/bin/bash

# Chemin vers la clé privée
KEY_PATH="/home/vagrant/.ssh/id_rsa"

# Vérifier si la clé existe
if [ -f "$KEY_PATH" ]; then
    echo "La clé SSH $KEY_PATH existe déjà."
    ls -l "$KEY_PATH"
else
    echo "La clé SSH $KEY_PATH n'existe pas. Génération en cours..."
    mkdir -p /home/vagrant/.ssh
    ssh-keygen -t rsa -b 2048 -f "$KEY_PATH" -q -N ""
    chmod 600 "$KEY_PATH"
    chown vagrant:vagrant "$KEY_PATH"
    echo "Clé SSH générée avec succès : $KEY_PATH"
    ls -l "$KEY_PATH"
fi

sudo yum update -y
sudo yum install python3-pip -y


#cat /home/vagrant/.ssh/id_rsa.pub >> /home/vagrant/.ssh/authorized_keys
sudo yum update -y
sudo yum install -y ansible

mkdir -p ~/ansible/roles

mkdir -p ~/ansible/roles/apache
mkdir -p ~/ansible/roles/apache/defaults
mkdir -p ~/ansible/roles/apache/handlers
mkdir -p ~/ansible/roles/apache/tasks
mkdir -p ~/ansible/roles/apache/vars

mkdir -p ~/ansible/roles/apache-inventory
mkdir -p ~/ansible/roles/apache-inventory/defaults
mkdir -p ~/ansible/roles/apache-inventory/meta
mkdir -p ~/ansible/roles/apache-inventory/tasks
mkdir -p ~/ansible/roles/apache-inventory/templates

mkdir -p ~/ansible/roles/mariadb
mkdir -p ~/ansible/roles/mariadb/handlers
mkdir -p ~/ansible/roles/mariadb/tasks

mkdir -p ~/ansible/roles/mediawiki
mkdir -p ~/ansible/roles/mediawiki/common/defaults
mkdir -p ~/ansible/roles/mediawiki/configuration
mkdir -p ~/ansible/roles/mediawiki/configuration/defaults
mkdir -p ~/ansible/roles/mediawiki/configuration/meta
mkdir -p ~/ansible/roles/mediawiki/configuration/tasks 
mkdir -p ~/ansible/roles/mediawiki/mariadb
mkdir -p ~/ansible/roles/mediawiki/mariadb/meta
mkdir -p ~/ansible/roles/mediawiki/mariadb/tasks 
