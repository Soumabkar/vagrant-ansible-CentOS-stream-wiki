#!/bin/bash

# Chemin vers le fichier de configuration SSH
SSHD_CONFIG="/etc/ssh/sshd_config"
sudo chmod 644 "$SSHD_CONFIG"

# Vérifier que le script est exécuté en tant que root
if [ "$(id -u)" -ne 0 ]; then
    echo "Ce script doit être exécuté en tant que root (sudo)." >&2
    exit 1
fi

# Sauvegarder le fichier original
cp "$SSHD_CONFIG" "${SSHD_CONFIG}.bak"
echo "Fichier original sauvegardé : ${SSHD_CONFIG}.bak"

#Donner les permissions appropriées au fichier de configuration SSH
chmod 644 "$SSHD_CONFIG"
echo "Permissions du fichier $SSHD_CONFIG définies sur 644."
sudo chmod 644 $SSHD_CONFIG

# Activer PubkeyAuthentication et désactiver PasswordAuthentication
sed -i 's/^#PubkeyAuthentication yes/PubkeyAuthentication yes/' "$SSHD_CONFIG"
sed -i 's/^#PasswordAuthentication yes/PasswordAuthentication no/' "$SSHD_CONFIG"

# Vérifier que PubkeyAuthentication est bien activé
if grep -q "^PubkeyAuthentication no" "$SSHD_CONFIG"; then
    echo "Erreur : PubkeyAuthentication est désactivé dans le fichier."
    echo "Modifiez manuellement $SSHD_CONFIG avant de continuer."
    exit 1
fi

# Redémarrer le service SSH
sudo systemctl restart sshd
if [ $? -eq 0 ]; then
    echo "Le service SSH a été redémarré avec succès."
    echo "Assurez-vous que votre clé SSH fonctionne avant de vous déconnecter !"
else
    echo "Erreur lors du redémarrage du service SSH." >&2
    exit 1
fi
echo "Configuration SSH mise à jour avec succès."