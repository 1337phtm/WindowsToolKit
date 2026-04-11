# Windows Tool Kit (WTK)

![PowerShell](https://img.shields.io/badge/PowerShell-5.1%20%7C%207+-blue)
![License](https://img.shields.io/badge/License-MIT--Custom-green)
![Platform](https://img.shields.io/badge/Platform-Windows-lightgrey)
![Status](https://img.shields.io/badge/Status-Active-success)

## Description

Ce dépôt contient un utilitaire Windows (WindowsToolKit : WTK) sous Powershell. Il regroupe plusieurs modules permettant d’automatiser, diagnostiquer et maintenir un système Windows de manière simple et efficace.

## 📋 Prérequis
- Windows 10 / 11
- PowerShell **5.1** ou **7+**
- Les Autorisation pour exécuter des scripts :

```powershell
   Get-ExecutionPolicy
   Set-ExecutionPolicy RemoteSigned CurrentUser
```
## 📥 Installation et MàJ

0. Si git n'est pas installé :
   ````powershell
   winget install --id Git.Git -e --source winget
   ````

1. Cloner le dépôt :

   ```powershell
   git clone https://github.com/1337phtm/WindowsToolKit.git
   cd WindowsToolKit
   ```
   1.1 Mettre à jour le dépôt :

   ````powershell
   git pull origin main
   ````
   - Il faut d'abord se placer dans le répertoire "WindowsToolKit"

2. Lancer l'outil :

   ```powershell
   .\Main.ps1
   ```

3. Lancer l'outil en mode debug :
   ```powershell
   .\Main.ps1 -DebugMode
   ```


## 🧰 Fonctionnalités

### 🔧 Toolbox Windows
- Informations système détaillées
- Réparation Windows (DISM /RestoreHealth, SFC /scannow)
- Outils réseau (IP, Ping, SpeedTest)
- Outils DiskPart (extensions futures)

### 📦 ZipArchive
- Création d’archives ZIP
- Export de dossiers (ex : CurseForge)

### 🔐 HashCheck
- Calcul de hash
- Comparaison de fichiers
- Vérification d’intégrité

### ⚙️ Setup
- Fonctions utilitaires communes
- Gestion des logs
- Gestion des erreurs
- Fonctions d’affichage (Stop‑Screen, etc.)


## 🧰 Architecture du projet

```text
WindowsToolKit/
│

│
├── src/                     # Code principal
│   ├──
│   └──
│
├── .gitignore
├── Main.ps1
├── README.md
├── LICENSE
└── CHANGELOG

