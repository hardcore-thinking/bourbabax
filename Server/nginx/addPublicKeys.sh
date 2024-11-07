#!/bin/bash

# Paramètres du client
HOST="172.128.0.5"               # L'adresse IP de la Machine B
PORT=7880                        # Le port sur lequel la Machine B écoute
COMMAND="airnet:add-public-keys" # La commande à envoyer
CSV_FILE="public_keys.csv"       # Le fichier CSV à envoyer

# Créer un paquet contenant la commande et le fichier CSV
# Nous envoyons d'abord la commande, puis le fichier CSV
{
    echo "$COMMAND" # Envoie la commande
    cat $CSV_FILE   # Envoie le fichier CSV
} | nc $HOST $PORT

echo "Commande et fichier envoyés à $HOST:$PORT."
