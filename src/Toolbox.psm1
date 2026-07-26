# Toolbox.psm1
# Outils système Windows (DISM, SFC, réseau, etc.)

. "$PSScriptRoot\Setup.ps1"

#======================================================================
# Menus d'affichage
#======================================================================

function Show-WindowsRepair {
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
    Clear-Host
    Write-Host ""
    Write-Host "╔══════════════════════════════════════╗" -ForegroundColor Cyan
    Write-Host "║           SYSTEM INFORMATION         ║" -ForegroundColor Cyan
    Write-Host "╚══════════════════════════════════════╝" -ForegroundColor Cyan

    # Création du tableau global
    $SystemInfo = @()

    # ==========================
    # WINDOWS
    # ==========================

    $info = Get-ComputerInfo
    $SystemInfo += [PSCustomObject]@{
        Categorie   = "Windows"
        Information = "Product Name"
        Valeur      = $info.WindowsProductName
    }

    $SystemInfo += [PSCustomObject]@{
        Categorie   = "Windows"
        Information = "Registered Owner"
        Valeur      = $info.WindowsRegisteredOwner
    }

    $SystemInfo += [PSCustomObject]@{
        Categorie   = "Windows"
        Information = "Hostname"
        Valeur      = $info.CsDNSHostName
    }

    $SystemInfo += [PSCustomObject]@{
        Categorie   = "Windows"
        Information = "Username"
        Valeur      = $info.CsUserName
    }

    $SystemInfo += [PSCustomObject]@{
        Categorie   = "Windows"
        Information = "OS Name"
        Valeur      = $info.OsName
    }

    # ==========================
    # CPU
    # ==========================

    $cpu = Get-CimInstance Win32_Processor
    $SystemInfo += [PSCustomObject]@{
        Categorie   = "CPU"
        Information = "Model"
        Valeur      = $cpu.Name
    }

    $SystemInfo += [PSCustomObject]@{
        Categorie   = "CPU"
        Information = "Cores"
        Valeur      = $cpu.NumberOfCores
    }

    $SystemInfo += [PSCustomObject]@{
        Categorie   = "CPU"
        Information = "Threads"
        Valeur      = $cpu.NumberOfLogicalProcessors
    }

    $SystemInfo += [PSCustomObject]@{
        Categorie   = "CPU"
        Information = "Frequency"
        Valeur      = "$($cpu.MaxClockSpeed) MHz"
    }

    # ==========================
    # GPU
    # ==========================

    $gpu = Get-CimInstance Win32_VideoController
    foreach ($card in $gpu) {

        $SystemInfo += [PSCustomObject]@{
            Categorie   = "GPU"
            Information = "Model"
            Valeur      = $card.Name
        }

        $SystemInfo += [PSCustomObject]@{
            Categorie   = "GPU"
            Information = "VRAM"
            Valeur      = "{0} GB" -f ([math]::Round($card.AdapterRAM / 1GB, 2))
        }

        $SystemInfo += [PSCustomObject]@{
            Categorie   = "GPU"
            Information = "Driver"
            Valeur      = $card.DriverVersion
        }
    }

    # ==========================
    # RAM
    # ==========================

    $os = Get-CimInstance Win32_OperatingSystem
    $computer = Get-CimInstance Win32_ComputerSystem

    $total = $computer.TotalPhysicalMemory
    $free = $os.FreePhysicalMemory * 1KB
    $used = $total - $free

    $SystemInfo += [PSCustomObject]@{
        Categorie   = "RAM"
        Information = "Installed"
        Valeur      = "{0} GB" -f ([math]::Round($total / 1GB, 2))
    }

    $SystemInfo += [PSCustomObject]@{
        Categorie   = "RAM"
        Information = "Used"
        Valeur      = "{0} GB" -f ([math]::Round($used / 1GB, 2))
    }

    $SystemInfo += [PSCustomObject]@{
        Categorie   = "RAM"
        Information = "Available"
        Valeur      = "{0} GB" -f ([math]::Round($free / 1GB, 2))
    }

    # ==========================
    # DISQUES
    # ==========================

    $disks = Get-CimInstance Win32_LogicalDisk -Filter "DriveType=3"

    foreach ($disk in $disks) {

        $SystemInfo += [PSCustomObject]@{
            Categorie   = "Disk"
            Information = "$($disk.DeviceID) Total"
            Valeur      = "{0} GB" -f ([math]::Round($disk.Size / 1GB, 2))
        }

        $SystemInfo += [PSCustomObject]@{
            Categorie   = "Disk"
            Information = "$($disk.DeviceID) Free"
            Valeur      = "{0} GB" -f ([math]::Round($disk.FreeSpace / 1GB, 2))
        }
    }

    $SystemInfo | Format-Table -GroupBy Categorie -AutoSize
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
                Write-Status ERROR "Invalid choice."
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
                Write-Status ERROR "Invalid choice."
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
                Write-Status ERROR "Invalid choice."
                Stop-Screen
            }
        }
    }
}

#======================================================================
# Windows Repair -- DISM & SFC
#======================================================================

function DISM {
    Write-Host ""
    Write-Host "Launching DISM /Online /Cleanup-Image /RestoreHealth..." -ForegroundColor Yellow
    Write-Host ""
    try {
        Start-Process -FilePath "dism.exe" -ArgumentList "/Online", "/Cleanup-Image", "/RestoreHealth" -Verb RunAs -Wait
        if ($LASTEXITCODE -ne 0) {
            throw "DISM failed with exit code $LASTEXITCODE"
        }
    }
    catch {
        Stop-Screen
        return
    }
    Write-Host ""
    Write-Host "DISM completed." -ForegroundColor Green
    Stop-Screen
}

function SFC {
    Write-Host ""
    Write-Host "Launching SFC /scannow..." -ForegroundColor Yellow
    Write-Host ""
    try {
        Start-Process -FilePath "sfc.exe" -ArgumentList "/scannow" -Verb RunAs -Wait
        if ($LASTEXITCODE -ne 0) {
            throw "SFC failed with exit code $LASTEXITCODE"
        }
    }
    catch {
        Write-Status ERROR "SFC failed with exit code $LASTEXITCODE"
        Stop-Screen
        return
    }
    Write-Host ""
    Write-Host "SFC completed." -ForegroundColor Green
    Stop-Screen
}

#======================================================================
# NetworkTools -- Network Informations
#======================================================================

function Get-NetworkInformations {
    Clear-Host

    try {
        $adapters = Get-NetAdapter -ErrorAction Stop

        Write-Host ""
        Write-Host "╔══════════════════════════════════════╗" -ForegroundColor Green
        Write-Host "║           NETWORK INFORMATIONS       ║" -ForegroundColor Green
        Write-Host "╚══════════════════════════════════════╝" -ForegroundColor Green
        Write-Host ""

        foreach ($adapter in $adapters) {
            $ip = Get-NetIPAddress -InterfaceIndex $adapter.ifIndex -AddressFamily IPv4 -ErrorAction SilentlyContinue

            Write-Host "════════════════════════════════════════"
            Write-Host " Adapter name : $($adapter.Name)"
            Write-Host " Description  : $($adapter.InterfaceDescription)"
            Write-Host " State        : $($adapter.Status)"
            Write-Host " IPv4 Address : $($ip.IPAddress)"
            Write-Host " MAC Address  : $($adapter.MacAddress)"
            Write-Host " Max Link speed : $($adapter.LinkSpeed)"
            Write-Host ""
        }
    }
    catch {
        Write-Status ERROR "Failed to retrieve network informations."
        Stop-Screen
        return
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
        Stop-Screen
        return
    }
    Stop-Screen
}

#======================================================================
# NetworkTools -- SpeedTest
#======================================================================

function Get-SpeedTest {
    Clear-Host

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

    try {
        # Installer uniquement si absent via winget
        if (-not (winget list --id $SpeedtestId | Select-String $SpeedtestId)) {
            Write-Host "Installing Ookla Speedtest CLI via winget..." -ForegroundColor Yellow
            Write-Host ""

            winget install $SpeedtestId `
                --accept-source-agreements `
                --accept-package-agreements `
                --silent

            if ($LASTEXITCODE -ne 0) {
                throw "Winget failed to install Speedtest (exit code $LASTEXITCODE)"
            }
        }

        Write-Host ""
        Write-Host "Running SpeedTest..." -ForegroundColor Cyan
        Write-Host ""

        speedtest --accept-license --accept-gdpr

        if ($LASTEXITCODE -ne 0) {
            throw "Speedtest CLI failed (exit code $LASTEXITCODE)"
        }

        Write-Host ""

        # Désinstaller proprement
        if (winget list --id $SpeedtestId | Select-String $SpeedtestId) {
            Write-Host "Cleaning up Speedtest installation..." -ForegroundColor Yellow

            winget uninstall $SpeedtestId `
                --silent `
                --accept-source-agreements

            if ($LASTEXITCODE -ne 0) {
                throw "Winget failed to uninstall Speedtest (exit code $LASTEXITCODE)"
            }
        }

    }
    catch {
        Write-Status ERROR "SpeedTest failed with exit code $LASTEXITCODE"
    }

    Stop-Screen
}


#======================================================================
# Export
#======================================================================

Export-ModuleMember -Function *-*
