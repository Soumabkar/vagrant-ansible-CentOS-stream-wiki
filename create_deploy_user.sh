#!/bin/bash

# Nom de l'utilisateur
USERNAME="master" #master deploy
PASSWORD="master" #master deploy

# Vérifier si l'utilisateur existe déjà
if id "$USERNAME" &>/dev/null; then
    echo "L'utilisateur $USERNAME existe déjà."

    # Vérifier s'il appartient déjà au groupe sudo
    if groups "$USERNAME" | grep -q '\bsudo\b'; then
        echo "$USERNAME appartient déjà au groupe sudo."
    else
        # Ajouter l'utilisateur au groupe sudo
        sudo usermod -aG sudo "$USERNAME"
        echo "$USERNAME a été ajouté au groupe sudo."
    fi
else
    # Créer l'utilisateur
    sudo useradd -m -s /bin/bash "$USERNAME"

    # Définir le mot de passe
    echo "$USERNAME:$PASSWORD" | sudo chpasswd

    # Ajouter l'utilisateur au groupe sudo
    sudo usermod -aG sudo "$USERNAME"

    echo "L'utilisateur $USERNAME a été créé avec succès et ajouté au groupe sudo."
fi
