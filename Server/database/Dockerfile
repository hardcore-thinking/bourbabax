# Utiliser l'image officielle de MySQL comme base
FROM mysql:latest

# Définir les variables d'environnement pour MySQL
ENV MYSQL_ROOT_PASSWORD=bourbabax256
ENV MYSQL_DATABASE=serverdb
ENV MYSQL_USER=www
ENV MYSQL_PASSWORD=bourbabax255

# Exposer le port par défaut de MySQL
EXPOSE 3306

# Copier les scripts SQL personnalisés
COPY ./init.sql /docker-entrypoint-initdb.d/init.sql

# Définir le point d'entrée pour démarrer MySQL
ENTRYPOINT ["docker-entrypoint.sh"]
CMD ["mysqld"]
