# Utilisation de l'image de base Debian stable
FROM debian:latest

# Variables pour réutilisation et clarté
ENV PATH="/venv/bin:$PATH"

# Mise à jour et installation des paquets nécessaires
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        curl \
        autossh \
        cron \
        netcat-openbsd \
        nano \
        python3 \
        python3-pip \
        python3-venv \
        iputils-ping \
        net-tools \
        openssh-server && \
    rm -rf /var/lib/apt/lists/*

# Configuration de l'environnement Python
RUN python3 -m venv /venv && \
    pip install --no-cache-dir mysql-connector-python

# Définir le répertoire de travail
WORKDIR /usr/local/bin

# Copier les fichiers nécessaires
COPY tcpService.sh ./tcpService.sh
COPY get_public_keys.py ./get_public_keys.py
COPY check_who_is_dead.py ./check_who_is_dead.py
COPY start.sh ./start.sh

# Rendre les scripts exécutables
RUN chmod +x tcpService.sh start.sh

# Exposer le port requis
EXPOSE 7880

# Commande de démarrage par défaut
CMD ["bash", "/usr/local/bin/start.sh"]