# Main.ps1
# Point d'entrée de WindowsToolkit

# Charger les modules locaux
Import-Module "$PSScriptRoot\Setup.psm1" -Force
Import-Module "$PSScriptRoot\Toolbox.psm1" -Force
Import-Module "$PSScriptRoot\ZipArchive.psm1" -Force
Import-Module "$PSScriptRoot\HashCheck.psm1" -Force

function Show-MainMenu {
    Write-Log "Starting Main Menu"
    Clear-Host
    Write-Host "╔══════════════════════════════════════╗" -ForegroundColor Green
    Write-Host "║            WINDOWS TOOLKIT           ║" -ForegroundColor Green
    Write-Host "║          WRITTEN BY 1337phtm         ║" -ForegroundColor Green    
    Write-Host "╚══════════════════════════════════════╝" -ForegroundColor Green
    Write-Host ""
    Write-Host "[1]  Toolbox" -ForegroundColor Cyan
    Write-Host "[2]  Zip Archive" #Couleur du premier menu affiché
    Write-Host "[3]  Hash Check" #Couleur du premier menu affiché
    Write-Host ""
    Write-Host "[0]  Exit"
    Write-Host ""
}

function Start-MainMenu {
    do {
        Show-MainMenu
        $choice = Read-Host "Choose an option"
        switch ($choice) {
            "1" { Start-ToolboxMenu }
            "2" { Start-ZipMenu }
            "3" { Start-HashMenu }
            "0" { Clear-Host; return }
            default {
                Write-Host "Invalid choice." -ForegroundColor Red
                Stop-Screen
            }
        }
    } until ($choice -eq "0")
}

# Lancer le menu principal
Start-MainMenu
