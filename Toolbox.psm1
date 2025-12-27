# Toolbox.psm1
# Outils système Windows (DISM, SFC, réseau, etc.)

Import-Module "$PSScriptRoot\Setup.psm1" -Force

#======================================================================
# Main - Menu principal Toolbox
#======================================================================

function Start-ToolboxMenu {
    while ($true) {
        Show-ToolboxMenu
        $choice = Read-Host "Select an option"
        switch ($choice) {
            "1" { Get-SystemInfo }
            "2" { Get-FixWin }
            "3" { Get-Diskpart }
            "4" { Get-NetworkTools }
            "0" { Clear-Host; return }
            default {
                Write-Host "Invalid choice." -ForegroundColor Red
                Stop-Screen
            }
        }
    }
}

#======================================================================
# Menus d'affichage
#======================================================================

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

function Show-WindowsRepair {
    Write-Log "Displaying Windows repair menu"
    Clear-Host
    Write-Host "╔══════════════════════════════════════╗" -ForegroundColor Cyan
    Write-Host "║              REPAIR MENU             ║" -ForegroundColor Cyan
    Write-Host "╚══════════════════════════════════════╝" -ForegroundColor Cyan
    Write-Host ""
    Write-Host "[1]  DISM"
    Write-Host "[2]  SFC"
    Write-Host ""
    Write-Host "[0]  Back" -ForegroundColor DarkGray
    Write-Host ""
}

function Show-Diskpart {
    Write-Log "Displaying Diskpart menu" 
    Clear-Host
    Write-Host "╔══════════════════════════════════════╗" -ForegroundColor Blue
    Write-Host "║            DISKPART MENU             ║" -ForegroundColor Blue
    Write-Host "╚══════════════════════════════════════╝" -ForegroundColor Blue
    Write-Host ""
    Write-Host "[1]  (reserved for future tools)"
    Write-Host "[2]  (reserved for future tools)"
    Write-Host ""
    Write-Host "[0]  Back" -ForegroundColor DarkGray
    Write-Host ""
}

function Show-NetworkTools {
    Write-Log "Displaying Network Tools menu"
    Clear-Host
    Write-Host "╔══════════════════════════════════════╗" -ForegroundColor DarkBlue
    Write-Host "║             NETWORK MENU             ║" -ForegroundColor DarkBlue
    Write-Host "╚══════════════════════════════════════╝" -ForegroundColor DarkBlue
    Write-Host ""
    Write-Host "[1]  Network Informations"
    Write-Host "[2]  Ping"
    Write-Host "[3]  SpeedTest"
    Write-Host ""
    Write-Host "[0]  Back" -ForegroundColor DarkGray
    Write-Host ""
}

#======================================================================
# System Informations
#======================================================================

function Get-SystemInfo {
    Write-Log "Displaying system information menu"
    Clear-Host
    Write-Host ""
    Write-Host "╔══════════════════════════════════════╗" -ForegroundColor Cyan
    Write-Host "║           SYSTEM INFORMATION         ║" -ForegroundColor Cyan
    Write-Host "╚══════════════════════════════════════╝" -ForegroundColor Cyan
    Write-Host ""

    $info = Get-ComputerInfo

    Write-Host " Windows Product Name : $($info.WindowsProductName)"
    Write-Host " Registered Owner     : $($info.WindowsRegisteredOwner)"
    Write-Host " HostName             : $($info.CsDNSHostName)"
    Write-Host " Memory               : $($info.CsPhyicallyInstalledMemory)"
    Write-Host " OS Name              : $($info.OsName)"
    Write-Host ""

    Write-Host " CPU Informations :" -ForegroundColor Yellow
    $info.CsProcessors |
        Select-Object Name,
                      @{ Name = 'Cores';   Expression = { $_.NumberOfCores } },
                      @{ Name = 'Threads'; Expression = { $_.NumberOfLogicalProcessors } },
                      MaxClockSpeed,
                      Manufacturer |
        Format-Table -AutoSize

    Stop-Screen
}

#======================================================================
# Windows Repair
#======================================================================

function Get-FixWin {
    while ($true) {
        Show-WindowsRepair
        $choice = Read-Host "Select an option"

        switch ($choice) {
            "1" { DISM }
            "2" { SFC }
            "0" { return }
            default {
                Write-Host "Invalid choice." -ForegroundColor Red
                Stop-Screen
            }
        }
    }
}

#======================================================================
# Diskpart (placeholder pour futur)
#======================================================================

function Get-Diskpart {
    while ($true) {
        Show-Diskpart
        $choice = Read-Host "Select an option"

        switch ($choice) {
            "1" { Write-Host "Diskpart tool 1 (coming soon)"; Stop-Screen }
            "2" { Write-Host "Diskpart tool 2 (coming soon)"; Stop-Screen }
            "0" { return }
            default {
                Write-Host "Invalid choice." -ForegroundColor Red
                Stop-Screen
            }
        }
    }
}

#======================================================================
# Network Tools
#======================================================================

function Get-NetworkTools {
    while ($true) {
        Show-NetworkTools
        $choice = Read-Host "Select an option"

        switch ($choice) {
            "1" { Get-NetworkInformations }
            "2" { Test-Ping }
            "3" { Get-SpeedTest }
            "0" { return }
            default {
                Write-Host "Invalid choice." -ForegroundColor Red
                Stop-Screen
            }
        }
    }
}

#======================================================================
# Windows Repair -- DISM & SFC
#======================================================================

function DISM {
    Write-Log "Launching DISM"
    Write-Host ""
    Write-Host "Launching DISM /Online /Cleanup-Image /RestoreHealth..." -ForegroundColor Yellow
    Write-Host ""

    Start-Process -FilePath "dism.exe" -ArgumentList "/Online","/Cleanup-Image","/RestoreHealth" -Verb RunAs -Wait

    Write-Host ""
    Write-Host "DISM completed." -ForegroundColor Green
    Write-Log "DISM finished"
    Stop-Screen
}

function SFC {
    Write-Log "Launching SFC"
    Write-Host ""
    Write-Host "Launching SFC /scannow..." -ForegroundColor Yellow
    Write-Host ""

    Start-Process -FilePath "sfc.exe" -ArgumentList "/scannow" -Verb RunAs -Wait

    Write-Host ""
    Write-Host "SFC completed." -ForegroundColor Green
    Write-Log "SFC finished"
    Stop-Screen
}

#======================================================================
# NetworkTools -- Network Informations
#======================================================================

function Get-NetworkInformations {
    Clear-Host
    Write-Log "Displaying network informations"

    $adapters = Get-NetAdapter

    Write-Host ""
    Write-Host "╔══════════════════════════════════════╗" -ForegroundColor Green
    Write-Host "║           NETWORK INFORMATIONS       ║" -ForegroundColor Green
    Write-Host "╚══════════════════════════════════════╝" -ForegroundColor Green
    Write-Host ""

    foreach ($adapter in $adapters) {
        $ip = Get-NetIPAddress -InterfaceIndex $adapter.ifIndex -AddressFamily IPv4 -ErrorAction SilentlyContinue

        Write-Host "----------------------------------------"
        Write-Host " Adapter name : $($adapter.Name)"
        Write-Host " Description  : $($adapter.InterfaceDescription)"
        Write-Host " State        : $($adapter.Status)"
        Write-Host " IPv4 Address : $($ip.IPAddress)"
        Write-Host " MAC Address  : $($adapter.MacAddress)"
        Write-Host " Link speed   : $($adapter.LinkSpeed)"
        Write-Host ""
    }

    Stop-Screen
}

#======================================================================
# NetworkTools -- Ping
#======================================================================

function Test-Ping {
    Clear-Host

    Write-Host ""
    Write-Host "╔══════════════════════════════════════╗" -ForegroundColor Green
    Write-Host "║                 PING                 ║" -ForegroundColor Green
    Write-Host "╚══════════════════════════════════════╝" -ForegroundColor Green
    Write-Host ""

    $target = Read-Host "Enter an IP or hostname"
    if ([string]::IsNullOrWhiteSpace($target)) {
        Write-Host "No target entered." -ForegroundColor Red
        Stop-Screen
        return
    }

    Write-Log "Ping sent to $target"
    Write-Host ""
    Write-Host "Testing connection to $target..."
    Write-Host ""

    try {
        $results = Test-Connection -ComputerName $target -Count 4 -ErrorAction Stop
        foreach ($r in $results) {
            Write-Host " Reply from $($r.IPV4Address) : time=$($r.ResponseTime) ms"
        }
    }
    catch {
        Write-Host "Ping failed for $target" -ForegroundColor Red
        Write-Log "Ping $target : FAIL"
    }

    Stop-Screen
}

#======================================================================
# NetworkTools -- SpeedTest
#======================================================================

function Get-SpeedTest {
    Clear-Host
    Write-Log "SpeedTest requested"

    $SpeedtestId = "Ookla.Speedtest.CLI"

    function Test-Internet {
        param(
            [string]$Url = "https://www.microsoft.com"
        )

        try {
            Invoke-WebRequest -Uri $Url -UseBasicParsing -TimeoutSec 5 | Out-Null
            return $true
        }
        catch {
            return $false
        }
    }

    Write-Host ""
    Write-Host "Checking internet connectivity..." -ForegroundColor Yellow
    Write-Host ""

    if (-not (Test-Internet)) {
        Write-Host "No internet access. Aborting SpeedTest." -ForegroundColor Red
        Stop-Screen
        return
    }

    Write-Host "Internet OK." -ForegroundColor Green
    Write-Host ""

    # Installer uniquement si absent via winget
    if (-not (winget list --id $SpeedtestId | Select-String $SpeedtestId)) {
        Write-Host "Installing Ookla Speedtest CLI via winget..." -ForegroundColor Yellow
        Write-Host ""
        winget install $SpeedtestId `
          --accept-source-agreements `
          --accept-package-agreements `
          --silent
    }

    Write-Host ""
    Write-Host "Running SpeedTest..." -ForegroundColor Cyan
    Write-Host ""

    speedtest --accept-license --accept-gdpr
    Write-Host ""

    # Désinstaller proprement
    if (winget list --id $SpeedtestId | Select-String $SpeedtestId) {
        Write-Host "Cleaning up Speedtest installation..." -ForegroundColor Yellow
        winget uninstall $SpeedtestId `
          --silent `
          --accept-source-agreements
    }

    Write-Log "SpeedTest finished"
    Stop-Screen
}

#======================================================================
# Export
#======================================================================

Export-ModuleMember -Function *-*
