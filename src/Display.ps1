function Show-ToolboxMenu {
    Write-Log "Displaying Windows toolbox menu"
    Clear-Host
    Write-Host "╔══════════════════════════════════════╗" -ForegroundColor DarkCyan
    Write-Host "║             TOOLBOX MENU             ║" -ForegroundColor DarkCyan
    Write-Host "╚══════════════════════════════════════╝" -ForegroundColor DarkCyan
    Write-Host ""
    Write-Host "[1]  System Informations"
    Write-Host "[2]  Repair Menu" -ForegroundColor DarkCyan
    Write-Host "[3]  Diskpart Menu" -ForegroundColor Blue
    Write-Host "[4]  Network Menu" -ForegroundColor DarkBlue
    Write-Host ""
    Write-Host "[0]  Back to main menu" -ForegroundColor DarkGray
    Write-Host ""
}

function Show-ZipMenu {
    Write-Log "Displaying Zip Archive menu"
    Clear-Host
    Write-Host "╔══════════════════════════════════════╗" -ForegroundColor DarkYellow
    Write-Host "║            Archive Backup            ║" -ForegroundColor DarkYellow
    Write-Host "╚══════════════════════════════════════╝" -ForegroundColor DarkYellow
    Write-Host ""
    Write-Host "[1]  Archive Zip"
    Write-Host "[2]  Archive CurseForge"
    Write-Host ""
    Write-Host "[0]  Back to main menu" -ForegroundColor DarkGray
    Write-Host ""
}

function Show-HashMainMenu {
    Write-Log "Displaying Hash Check menu"
    Clear-Host
    Write-Host "╔══════════════════════════════════════╗" -ForegroundColor Magenta
    Write-Host "║             HASHCHECK MENU           ║" -ForegroundColor Magenta
    Write-Host "╚══════════════════════════════════════╝" -ForegroundColor Magenta
    Write-Host ""
    Write-Host "[1]  Hash Check Copy"
    Write-Host "[2]  Hash Check Verify"
    Write-Host "[3]  Hash Check Remove"
    Write-Host ""
    Write-Host "[0]  back to main menu" -ForegroundColor DarkGray
    Write-Host ""
}

function Show-GitMenu {
    Clear-Host
    Write-Host "╔══════════════════════════════════════╗" -ForegroundColor Green
    Write-Host "║               GIT TOOLKIT            ║" -ForegroundColor Green
    Write-Host "╚══════════════════════════════════════╝" -ForegroundColor Green
    Write-Host ""
    Write-Host "[1]  Install git" -ForegroundColor DarkCyan
    Write-Host "[2]  Clone repo from user" -ForegroundColor DarkYellow
    Write-Host "[3]  Remove repo" -ForegroundColor Magenta
    Write-Host ""
    Write-Host "[0]  Back to main menu" -ForegroundColor DarkGray
    Write-Host ""
}

function Show-WingetMenu {
    Write-Log "Starting Main Menu"
    Clear-Host
    Write-Host "╔══════════════════════════════════════╗" -ForegroundColor Green
    Write-Host "║              WINGET MENU             ║" -ForegroundColor Green
    Write-Host "╚══════════════════════════════════════╝" -ForegroundColor Green
    Write-Host ""
    Write-Host "[1]  Install apps" -ForegroundColor DarkCyan
    Write-Host "[2]  Remove apps" -ForegroundColor DarkYellow
    Write-Host "[3]  Upgrade apps" -ForegroundColor Magenta
    Write-Host "[4]  Search apps" -ForegroundColor Blue
    Write-Host ""
    Write-Host "[0]  Back to main menu" -ForegroundColor DarkGray
    Write-Host ""
}