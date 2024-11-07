#!/bin/bash

# Paramètres du serveur
PORT=7880                                   # Le port sur lequel écouter
AUTHORIZED_KEYS_DIR="/home/authorized-keys" # Répertoire pour enregistrer les clés
ALLOWED_COMMAND="airnet:add-public-keys"    # La commande autorisée

# Écouter sur le port et traiter la commande et le fichier reçu
echo "Serveur en écoute sur le port $PORT..."

# Attendre la connexion et recevoir la commande + fichier
nc -l -p $PORT | while read line; do
    # Lire la commande envoyée par la Machine A
    if [[ -z "$command_received" ]]; then
        command_received="$line"
        echo "Commande reçue : $command_received"

        # Vérifier que la commande est correcte
        if [[ "$command_received" != "$ALLOWED_COMMAND" ]]; then
            echo "Commande invalide : $command_received. Connexion fermée."
            exit 1 # Ferme la connexion en cas de commande invalide
        fi
    else
        # À ce moment, on reçoit le fichier CSV
        echo "$line" >> "$AUTHORIZED_KEYS_DIR/public_keys.csv"
        echo "Clés publiques ajoutées au fichier $AUTHORIZED_KEYS_DIR/public_keys.csv"
    fi
done
