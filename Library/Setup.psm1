# Setup.psm1
# Fonctions communes (affichage, logs, etc.)

#======================================================================
# Fonctions de log
#======================================================================

# Répertoire parent du script
$ParentDir = Split-Path $PSScriptRoot -Parent

# Dossier log
$LogDir = Join-Path $ParentDir "WTK log"

# Création si nécessaire
if (!(Test-Path $LogDir)) {
    New-Item -ItemType Directory -Path $LogDir | Out-Null
}

# Fichier log global
$Global:LogFile = Join-Path $LogDir "WindowsToolkit.log"

function Write-Log {
    param(
        [string]$Message
    )

    $date = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
    Add-Content -Path $Global:LogFile -Value "[$date] $Message"

}

#======================================================================
# Fonction de gestion du log avec rotation
#======================================================================
function Start-Log { 
# Fichier compteur
$RunCountFile = Join-Path $LogDir "run.count"

# Si le fichier n'existe pas, on le crée avec 0
if (!(Test-Path $RunCountFile)) {
    "0" | Out-File $RunCountFile -Encoding UTF8
}

# Lire le compteur
$RunCount = [int](Get-Content $RunCountFile)

# Incrémenter
$RunCount++

# Sauvegarder
$RunCount | Out-File $RunCountFile -Encoding UTF8

# Si plus de 10 exécutions → rotation du log
if ($RunCount -gt 10) {

    $OldLog = Join-Path $LogDir "WindowsToolkit.log.old"

    # Copier le contenu dans .old
    if (Test-Path $Global:LogFile) {
        "===== Rotation $(Get-Date) =====" | Out-File $OldLog -Encoding UTF8 -Append
        Get-Content $Global:LogFile | Out-File $OldLog -Encoding UTF8 -Append
    }

    # Vider le log principal
    "" | Out-File -FilePath $Global:LogFile -Encoding UTF8

    # Reset compteur
    "0" | Out-File $RunCountFile -Encoding UTF8

    Write-Host "Log rotated → .log.old created." -ForegroundColor Yellow
}
}

#======================================================================
# Fonctions d'affichage
#======================================================================

function Stop-Screen {
    Write-Host ""
    Read-Host "Press Enter to continue..."
}

Export-ModuleMember -Function *-*
Export-ModuleMember -Function $RunCount