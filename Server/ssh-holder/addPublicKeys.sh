#!/bin/bash

# Configuration du serveur distant
SERVER="172.128.0.5"  # Remplace par l'adresse IP du serveur
PORT=7880             # Port du serveur auquel se connecter

# Commande à envoyer
COMMAND="airnet:add-public-keys"  # La commande autorisée

# Vérifier si Netcat est installé
if ! command -v nc &> /dev/null; then
    echo "Netcat (nc) is required to run this script."
    exit 1
fi

# Test de la connexion TCP et fermeture de nc après l'envoi du message (-q 1 = fermer après 1 seconde)
echo "Trying to connect to the server $SERVER on port $PORT..."
echo "$COMMAND" | nc -q 1 $SERVER $PORT

# Vérification du code de retour de Netcat
if [ $? -eq 0 ]; then
    echo "Command sent successfully."
    
else
    echo "Failed to send command. Please check the server configuration."
fi