# Bourbabax-airnet

## Sommaire

- [Bourbabax-airnet](#bourbabax-airnet)
  - [Sommaire](#sommaire)
  - [I. Introduction](#i-introduction)
  - [II. To Do List](#ii-to-do-list)
  - [III. Lancement](#iii-lancement)
  - [IV. Documentation détaillée](#iv-documentation-détaillée)

## I. Introduction

Bourbabax-airnet est un projet de simulation d'architecture pour le contrôle de Raspberry à distance.
L'architecture est composée de plusieurs blocs :

- **Private network** : Chaque groupe de Raspberry est contenu dans un réseau local privé et isolé de tout le reste. Les Raspberry sont accéssible via des tunnels RSSH.
- **Serveur Public** : Contient les composants nécessaires pour permettre la connexion entre un client et un réseau de Raspberry. Le serveur public est divisé en plusieurs parties :
  - *API Server* : Permet de faire la liaison entre le client et les Raspberry.
  - *Private Airnet Server* : Se charge de stocker les clés SSH publiques des Raspberry. Il communique en TCP avec l'API Server.
  - *Database* : Stocke les informations des Raspberry.
- **Client** : Permet de se connecter à un réseau de Raspberry et de les contrôler à distance.

## II. To Do List

[Trello](https://trello.com/invite/b/672b2e475fbae1639ffe1d94/ATTIfa09d0b4164440de9971bb78d55c1b521048DDC6/bourebax)

## III. Lancement

1- Lancer le serveur:

```bash
docker compose -f .\Server\docker-compose.yaml up -d
```

2- Lancer les Raspberry

```bash
docker build -t debian_archi .\Raspberry\
```

```bash
docker run -d -it -p 80:80 -p 443:443 -p 8022:8022 -p 8080:8080 -p 8327:8327 -p 8443:8443 -p 18327:18327 debian_archi
```

## IV. Documentation détaillée

[Lien vers le wiki](https://github.com/hardcore-thinking/bourbabax/wiki)
