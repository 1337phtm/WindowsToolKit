# ============================
#   WindowsToolkit - Setup
#   Auteur : 1337phtm
# ============================

# --- Préférences globales ---
$Global:ErrorActionPreference = "Stop"
$Global:VerbosePreference = "SilentlyContinue" #"Continue" (pour les afficher)
$Global:DebugPreference = "Continue"

# --- Dossier AppData ---
$Global:WTKRoot = Join-Path $env:LOCALAPPDATA "WindowsToolkit"
$Global:LogDir  = Join-Path $Global:WTKRoot "Logs"

foreach ($dir in @($Global:WTKRoot, $Global:LogDir)) {
    if (-not (Test-Path $dir)) {
        New-Item -ItemType Directory -Path $dir | Out-Null
    }
}

# --- Fichier de log principal ---
$Global:LogFile = Join-Path $Global:LogDir "WindowsToolkit.log"

if (-not (Test-Path $Global:LogFile)) {
    New-Item -ItemType File -Path $Global:LogFile | Out-Null
}

# --- Fonction de log centralisée ---
function Write-Log {
    param(
        [string]$Message,
        [string]$Level = "INFO"
    )

    $timestamp = (Get-Date).ToString("yyyy-MM-dd HH:mm:ss")
    $line = "[$timestamp] [$Level] $Message"

    Add-Content -Path $Global:LogFile -Value $line
}

# --- Gestion globale des erreurs ---
trap {
    $msg = $_.Exception.Message
    Write-Log -Message "TRAP: $msg" -Level "ERROR"
    Write-Error $msg
    continue
}

# --- Compteur d'exécutions + rotation ---
function Start-Log {

    $RunCountFile = Join-Path $Global:LogDir "run.count"

    if (-not (Test-Path $RunCountFile)) {
        "0" | Out-File $RunCountFile -Encoding UTF8
    }

    $RunCount = [int](Get-Content $RunCountFile)
    $RunCount++
    $RunCount | Out-File $RunCountFile -Encoding UTF8

    if ($RunCount -gt 10) {

        $OldLog = Join-Path $Global:LogDir "WindowsToolkit.log.old"

        "===== Rotation $(Get-Date) =====" | Out-File $OldLog -Encoding UTF8 -Append
        Get-Content $Global:LogFile | Out-File $OldLog -Encoding UTF8 -Append

        Clear-Content -Path $Global:LogFile

        "0" | Out-File $RunCountFile -Encoding UTF8

        Write-Host "Log rotated → .log.old created." -ForegroundColor Yellow
    }
}

# --- Fonction d'affichage ---
function Stop-Screen {
    Write-Host ""
    Read-Host "Press Enter to continue..."
}

# --- Export des fonctions publiques ---
Export-ModuleMember -Function Write-Log, Start-Log, Stop-Screen
