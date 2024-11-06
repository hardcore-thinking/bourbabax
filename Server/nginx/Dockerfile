# Utiliser l'image officielle nginx comme base
FROM nginx:latest

# Installer supervisord
RUN apt-get update && apt-get install -y supervisor

# Créer le répertoire de configuration de supervisord
RUN mkdir -p /etc/supervisor/conf.d

# Copier la configuration nginx personnalisée
COPY ./default.conf /etc/nginx/conf.d/default.conf

# Copier la configuration de supervisord
COPY ./supervisord.conf /etc/supervisor/conf.d/supervisord.conf

# Exposer les ports nécessaires
EXPOSE 80 443

# Lancer supervisord pour superviser nginx
CMD ["/usr/bin/supervisord", "-c", "/etc/supervisor/conf.d/supervisord.conf"]