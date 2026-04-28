# Main.ps1
# Point d'entrée de WindowsToolkit

#======================================================================
# Importation des modules
#======================================================================
. $PSScriptRoot\src\Setup.ps1
. $PSScriptRoot\src\Display.ps1
. $PSScriptRoot\src\Options.ps1

Import-Module "$PSScriptRoot\src\Toolbox.psm1" -Force -DisableNameChecking
Import-Module "$PSScriptRoot\src\ZipArchive.psm1" -Force -DisableNameChecking
Import-Module "$PSScriptRoot\src\HashCheck.psm1" -Force -DisableNameChecking
Import-Module "$PSScriptRoot\src\GitInstall\InstallGit.psm1" -Force -DisableNameChecking
Import-Module "$PSScriptRoot\src\GitInstall\CloneRepo.psm1" -Force -DisableNameChecking
Import-Module "$PSScriptRoot\src\GitInstall\RemoveRepo.psm1" -Force -DisableNameChecking
Import-Module "$PSScriptRoot\src\Winget\winget.psm1" -Force -DisableNameChecking

#======================================================================
# Affichage du menu principal
#======================================================================
function Show-MainMenu {
    Clear-Host
    Write-Host "╔══════════════════════════════════════╗" -ForegroundColor Green
    Write-Host "║            WINDOWS TOOLKIT           ║" -ForegroundColor Green
    Write-Host "║          WRITTEN BY 1337phtm         ║" -ForegroundColor Green
    Write-Host "╚══════════════════════════════════════╝" -ForegroundColor Green
    Write-Host ""
    Write-Host "[1]  Toolbox Menu" -ForegroundColor DarkCyan
    Write-Host "[2]  Zip Archive Menu" -ForegroundColor DarkYellow
    Write-Host "[3]  HashCheck Menu" -ForegroundColor Magenta
    #Write-Host "[1]  Windows toolbox" -ForegroundColor Magenta
    Write-Host "[4]  Git Menu" -ForegroundColor Blue
    Write-Host "[5]  Winget Menu" -ForegroundColor Blue
    Write-Host ""
    Write-Host "[0]  Exit" -ForegroundColor DarkGray
    Write-Host ""
}

#======================================================================
# Fonction du menu principal
#======================================================================
function Start-MainMenu {
    do {
        Show-MainMenu
        $choice = Read-Host "Choose an option"
        switch ($choice) {
            "1" {
                Start-ToolboxMenu
            }
            "2" {
                Start-ZipMenu
            }
            "3" {
                Start-HashMenu
            }
            "4" {
                Start-Git
            }
            "5" {
                Start-WingetMenu
            }
            "0" {
                Clear-Host
                return
            }
            default {
                Write-Host ""
                Write-Host "Invalid choice. Please try again." -ForegroundColor Red
                Stop-Screen
            }
        }
    } until ($choice -eq "0")
}

#======================================================================
# Démarrage du programme
#======================================================================
Start-MainMenu
