# Utiliser l'image officielle de MySQL comme base
FROM mysql:latest

# Exposer le port par défaut de MySQL
EXPOSE 3306

# Copier les scripts SQL personnalisés
COPY ../init.sql /docker-entrypoint-initdb.d/init.sql

RUN mysqld --initialize-insecure

# Définir le point d'entrée pour démarrer MySQL
ENTRYPOINT ["docker-entrypoint.sh"]
CMD ["mysqld"]
