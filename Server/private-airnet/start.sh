#!/bin/bash
# Démarrer les deux scripts en arrière-plan
./tcpService.sh &
python3 check_who_is_dead.py &

# Garder le conteneur actif
wait