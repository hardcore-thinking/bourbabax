# Utiliser une image Debian comme base
FROM debian:bullseye

# Mettre à jour et installer OpenSSH Server
RUN apt-get update && apt-get install -y \
    openssh-server \
    && apt-get clean

# Configurer le serveur SSH
RUN mkdir /var/run/sshd

# Ajouter un utilisateur pour la connexion SSH
RUN useradd -m -s /bin/bash sshuser && echo "sshuser:sshpassword" | chpasswd

# Autoriser l'authentification par mot de passe
RUN sed -i 's/^#PasswordAuthentication yes/PasswordAuthentication yes/' /etc/ssh/sshd_config
RUN sed -i 's/^PasswordAuthentication no/PasswordAuthentication yes/' /etc/ssh/sshd_config

# Permettre le routage du trafic
RUN echo "PermitTunnel yes" >> /etc/ssh/sshd_config

# Ouvrir le port 22
EXPOSE 22

# Lancer le serveur SSH
CMD ["/usr/sbin/sshd", "-D"]