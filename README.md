# 🐳 Windrose Dedicated Server - GSH Standard

## 📌 Description

Image Docker dédiée au serveur Windrose, entièrement standardisée pour l’écosystème GameServer-Hub (GSH).

Cette image permet de déployer facilement un serveur Windrose sous Linux via Wine + SteamCMD, avec gestion automatique de l'installation, des mises à jour et du lancement.

---

## 🚀 Features

- Installation automatique via SteamCMD
- Support Wine (serveur Windows sous Linux)
- Mise à jour automatique du serveur
- Variables GSH unifiées (`GSH_*`)
- Structure standard pour tous les jeux GSH
- Compatible Docker, VPS et serveur dédié

---

## 📁 Structure GSH

```txt
/opt/steam            -> SteamCMD (persistant)
/opt/games/server     -> Fichiers du serveur
/opt/games/config     -> Configuration externe
/opt/wine             -> Environnement Wine
```

---

## ⚙️ Variables d’environnement (GSH)

### 🔧 Général

```env
GSH_TZ=Europe/Paris
GSH_PUID=1000
GSH_PGID=1000
```

---

### 📦 Steam

```env
GSH_STEAM_APP_ID=4129620
GSH_STEAM_USER=anonymous
GSH_STEAM_PASSWORD=

GSH_GAME_UPDATE=true
GSH_VALIDATE_FILES=true
```

---

### 🎮 Serveur Windrose

```env
GSH_SERVER_NAME=GSH Windrose Server
GSH_SERVER_PASSWORD=
GSH_MAX_PLAYERS=4
```

---

### 🌐 Réseau

```env
GSH_GAME_PORT=7777
```

---

### 🧠 Wine

```env
GSH_USE_WINE=true
GSH_WINEPREFIX=/opt/wine/windrose
GSH_WINEARCH=win64
```

---

### ⚙️ Exécution

```env
GSH_SERVER_EXE=WindroseServer.exe
```

---

## 🔌 Ports

- `7777/udp` → Game Port
- `7777/tcp` → Direct Connection (si utilisé)

---

## 💾 Volumes

```yaml
volumes:
  - ./data/server:/opt/games/server
  - ./data/config:/opt/games/config
  - ./data/wine:/opt/wine
  - ./data/steam:/opt/steam
```

---

## ▶️ Exemple docker-compose

```yaml
version: "3.8"

services:
  windrose:
    image: slymer29/gsh-windrose:latest
    container_name: gsh-windrose
    restart: unless-stopped

    ports:
      - "7777:7777/udp"
      - "7777:7777/tcp"

    environment:
      GSH_SERVER_NAME: "Mon serveur Windrose"
      GSH_MAX_PLAYERS: 4

    volumes:
      - ./data/server:/opt/games/server
      - ./data/config:/opt/games/config
      - ./data/wine:/opt/wine
      - ./data/steam:/opt/steam
```

---

## ⚠️ Important

- Windrose Dedicated Server est une application Windows exécutée via Wine
- Le premier démarrage peut être long (SteamCMD télécharge le serveur)
- L’image ne contient pas les fichiers du jeu
- Les fichiers sont installés automatiquement au premier lancement

---

## 🎯 Intégration GameServer-Hub

Cette image suit le standard GSH :

- Variables unifiées (`GSH_*`)
- Structure identique pour tous les jeux
- Déploiement automatisé
- Gestion simplifiée côté panel

---

## 🔥 Auteur

Image maintenue par **slymer29**

Optimisée pour l’écosystème **GameServer-Hub (GSH)**
