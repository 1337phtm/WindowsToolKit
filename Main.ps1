# Main.ps1
# Point d'entrée de WindowsToolkit

#======================================================================
# Importation des modules
#======================================================================
Import-Module "$PSScriptRoot\Library\Setup.psm1" -Force -DisableNameChecking
Start-Log
Import-Module "$PSScriptRoot\Library\Toolbox.psm1" -Force -DisableNameChecking
Import-Module "$PSScriptRoot\Library\ZipArchive.psm1" -Force -DisableNameChecking
Import-Module "$PSScriptRoot\Library\HashCheck.psm1" -Force -DisableNameChecking

#======================================================================
# Affichage du menu principal
#======================================================================
function Show-MainMenu {
    Write-Log "Starting Main Menu"
    Clear-Host
    Write-Host "╔══════════════════════════════════════╗" -ForegroundColor Green
    Write-Host "║            WINDOWS TOOLKIT           ║" -ForegroundColor Green
    Write-Host "║          WRITTEN BY 1337phtm         ║" -ForegroundColor Green    
    Write-Host "╚══════════════════════════════════════╝" -ForegroundColor Green
    Write-Host ""
    Write-Host "[1]  Toolbox Menu" -ForegroundColor DarkCyan
    Write-Host "[2]  Zip Archive Menu" -ForegroundColor DarkYellow
    Write-Host "[3]  HashCheck Menu" -ForegroundColor Magenta
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
                Write-Log "Choice 1 selected: Toolbox Menu"
            }
            "2" { 
                Start-ZipMenu 
                Write-Log "Choice 2 selected: Zip Archive Menu"
            }
            "3" { 
                Start-HashMenu 
                Write-Log "Choice 3 selected: HashCheck Menu"
            }
            "0" { 
                Clear-Host 
                Write-Log "════════════════════════════════════════════ Exiting 1337phtm's Windows Toolkit ════════════════════════════════════════════"; 
                return
            }
            default {
                Write-Host "Invalid choice." -ForegroundColor Red
                Write-ErrorLog -Source "Main Menu" -Message "Invalid choice : $choice" -Silent
                Stop-Screen
            }
        }
    } until ($choice -eq "0")
}

#======================================================================
# Démarrage dU programme
#======================================================================
Write-Log "════════════════════════════════════════════ 1337phtm's Windows Toolkit started ════════════════════════════════════════════"
Start-MainMenu
