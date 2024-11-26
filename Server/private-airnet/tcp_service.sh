#!/bin/bash

# Configuration
PORT=7880                                                # Port d'écoute
AUTHORIZED_KEYS_FILE="/root/.ssh/authorized_keys"        # Fichier pour les clés SSH
ALLOWED_COMMAND="airnet:add-public-keys"                 # Commande autorisée
UPDATE_DB_SCRIPT="/usr/local/bin/get_public_keys.py"     # Script Python à exécuter

# Assurez-vous que le fichier des clés existe
mkdir -p "$(dirname "$AUTHORIZED_KEYS_FILE")"
touch "$AUTHORIZED_KEYS_FILE"
chmod 600 "$AUTHORIZED_KEYS_FILE"

echo "Server listening on port $PORT..."

python3 check_who_is_dead.py > /usr/local/bin/test.txt
# Boucle infinie pour écouter les connexions
while true; do
    # Intercepter une connexion via netcat
    # -k : pour permettre la réutilisation du serveur sans le fermer à chaque connexion
    nc -lk -p $PORT | while read line; do
        echo "Message received: $line"

        # Extraction de la commande
        command=$(echo "$line" | awk '{print $1}')

        # Vérifier la commande
        if [[ "$command" == "$ALLOWED_COMMAND" ]]; then
            echo "Valid command: $command"

            # Récupération de la liste des clés SSH dans la BDD
            python3 "$UPDATE_DB_SCRIPT"

            # Récupération des clées SSH dans le fichier de sortie du script ssh_keys.txt
            while read ssh_key; do
                # Ajouter la clé SSH à authorized_keys
                echo "$ssh_key" >> "$AUTHORIZED_KEYS_FILE"
            done < ssh_keys.txt
            echo "Public keys added to $AUTHORIZED_KEYS_FILE"
            rm ssh_keys.txt
        else
            echo "Invalid command: $command. Ignoring..."
        fi
    done
done