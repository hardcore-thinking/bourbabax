# Bourbabax-airnet

## Sommaire

- [Bourbabax-airnet](#bourbabax-airnet)
  - [Sommaire](#sommaire)
  - [I. Introduction](#i-introduction)
  - [Stack technique](#stack-technique)
  - [Fonctionnement](#fonctionnement)
  - [II. To Do List](#ii-to-do-list)
  - [III. Prérequis](#iii-prérequis)
    - [Initialisation \& Lancement](#initialisation--lancement)
  - [IV. Documentation détaillée](#iv-documentation-détaillée)

## I. Introduction

Bourbabax-airnet est un projet de simulation d'architecture pour le contrôle de Raspberry à distance.
L'architecture est composée de trois bloc principaux :

- **Réseau local** : Un réseau local de Raspberry Pi qui simule un réseau de capteurs.
- **Client** : Un client qui permet de contrôler les Raspberry à distance.
- **Serveur** : Un serveur qui permet de gérer les utilisateurs et les Raspberry, en permettant la connexion à distance en RSSH.

## Stack technique

L'ensemble des composants de l'architecture sont conteneurisés avec Docker.

- **Serveur Public** : Debian, Traefik
- **API Server** : Laravel, PHP
- **Private Airnet Server** : Debian, OpenSSH, Python, TCP
- **Database** : MySQL

## Fonctionnement

Lors de la première connexion, le Raspberry envoie une requête au serveur public pour s'inscrire. Le serveur public enregistre le Raspberry dans la base de données et lui attribue un port SSH de connexion.

Le serveur public envoie une commande en TCP au Private Airnet Server pour mettre à jour le fichier authorized_keys.

Le Serveur peut alors se connecter au Raspberry en RSSH. Le client peut se connecter au serveur public pour contrôler les Raspberry à distance. (Work in progress)

## II. To Do List

[Lien vers le Trello](https://trello.com/invite/b/672b2e475fbae1639ffe1d94/ATTIfa09d0b4164440de9971bb78d55c1b521048DDC6/bourebax)

## III. Prérequis

- Docker
- Docker-compose
- Git
- Un serveur sous debian avec une IP fixe

### Initialisation & Lancement

1 - Exécuter la commande suivante pour lancer les conteneurs du serveur en arrière plan

```bash
docker compose -f .\Server\docker-compose.yaml up -d
```

2 - Lancer cette commande pour build les Rasberry (/!\ en dehors du serveur public)

```bash
docker build -t debian_archi .\Raspberry\
```

3 - Lancer les Raspberry (/!\ en dehors du serveur public)

```bash
docker run -d -it -p 80:80 -p 443:443 -p 8022:8022 -p 8080:8080 -p 8327:8327 -p 8443:8443 -p 18327:18327 debian_archi
```

## IV. Documentation détaillée

[Lien vers le wiki](https://github.com/hardcore-thinking/bourbabax/wiki)
