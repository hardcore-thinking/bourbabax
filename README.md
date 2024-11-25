# bourbabax

## Sommaire

- [I-Introduction](#i-introduction)
- [II-To Do List](#ii-to-do-list)
- [III-Lancement](#iii-lancement)
- [IV-Documentation](#iv-documentation)

## I-Introduction

L'objectif de ce projet est de permettre a un serveur public de ce connecter et monitorer une ou plusieur machine chaqu'une dans un réseau privé.
La connexion se fait a l'aide d'un tunnel RSSH

## II-To Do List

[Trello](https://trello.com/b/CA6SATEa/bourebax)

## III-Lancement

1- Lancer le serveur:
```
docker compose -f .\Server\docker-compose.yaml up -d
```
```
docker build -t debian_archi .\Raspberry\
```
```
docker run -d -it -p 80:80 -p 443:443 -p 8022:8022 -p 8080:8080 -p 8327:8327 -p 8443:8443 -p 18327:18327 debian_archi
```

## IV-Documentation

[Lien vers le wiki](https://github.com/hardcore-thinking/bourbabax/wiki)


