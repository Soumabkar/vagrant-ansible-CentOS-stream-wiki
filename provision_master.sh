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

sudo apt update
sudo apt install python3-pip -y
pip3 install --user pywinrm

#cat /home/vagrant/.ssh/id_rsa.pub >> /home/vagrant/.ssh/authorized_keys
sudo apt-get update
sudo apt-get install -y ansible

mkdir -p ~/ansible

