# UI.psm1
# Fonctions communes (affichage, logs, etc.)

$Global:LogFile = Join-Path $PSScriptRoot "WindowsToolkit.log"

function Write-Log {
    param(
        [string]$Message
    )
    $date = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
    Add-Content -Path $Global:LogFile -Value "[$date] $Message"
}

function Stop-Screen {
    Write-Host ""
    Read-Host "Press Enter to continue..."
}

Export-ModuleMember -Function *-*
