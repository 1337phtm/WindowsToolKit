# Powershell

## Description

Ce dépôt contient un utilitaire Windows sous Powershell.

## Prérequis

- PowerShell 5.1 ou PowerShell 7+
- Les droits nécessaires pour exécuter des scripts sur la machine

## 📥 Installation

1. Cloner le dépôt :

   ```powershell
   git clone https://github.com/1337phtm/WindowsToolKit.git
   cd Powershell
2. Lancer l'outil :

   ```powershell
   .\Main.ps1
# 🚀 WindowsToolkit 

Toolkit Windows en PowerShell développé par **Phantom__m (1337phtm)**. 
Il regroupe plusieurs modules permettant d’automatiser, diagnostiquer et maintenir un système Windows de manière simple et efficace. 


## 🧰 Fonctionnalités 

### 🔧 Toolbox Windows 
- Informations système détaillées 
- Réparation Windows (DISM /RestoreHealth, SFC /scannow) 
- Outils réseau (IP, Ping, SpeedTest) 
- Outils DiskPart (extensions futures) 

### 📦 ZipArchive 
- Création d’archives ZIP 
- Sauvegardes automatisées 
- Export de dossiers (ex : CurseForge) 

### 🔐 HashCheck 
- Calcul de hash 
- Comparaison de fichiers 
- Vérification d’intégrité 

### ⚙️ Setup 
- Fonctions utilitaires communes 
- Gestion des logs 
- Fonctions d’affichage (Stop‑Screen, etc.) 


## 📋 Prérequis 
- Windows 10 / 11 
- PowerShell **5.1** ou **7+** 
- Autorisation d’exécuter des scripts : 

```powershell 
Get-ExecutionPolicy
Set-ExecutionPolicy RemoteSigned -Scope CurrentUser