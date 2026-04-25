function Start-ToolboxMenu {
    while ($true) {
        Show-ToolboxMenu
        $choice = Read-Host "Select an option"
        switch ($choice) {
            "1" { 
                Get-SystemInfo 
                Write-Log "Choice 1 selected: System Informations"
            }
            "2" { 
                Get-FixWin 
                Write-Log "Choice 2 selected: Repair Menu"
            }
            "3" { Get-Diskpart 
                Write-Log "Choice 3 selected: Diskpart Menu"
            }
            "4" { 
                Get-NetworkTools 
                Write-Log "Choice 4 selected: Network Menu"
            }
            "0" { return }
            default {
                Write-Host "Invalid choice." -ForegroundColor Red
                Write-ErrorLog -Source "ToolBox Menu" -Message "Invalid choice : $choice" -Silent
                Stop-Screen
            }
        }
    }
}

function Start-ZipMenu {
    while ($true) {
        Show-ZipMenu
        $choice = Read-Host "Choose an option"
        switch ($choice) {
            "1" { 
                Get-Archivebackup 
                Write-log "Choice 1 selected: Archive Backup"  
            }
            "2" { 
                Get-CurseforgeBackup 
                Write-log "Choice 2 selected: CurseForge Backup"  
            }
            "0" { return }
            default {
                Write-Host "Invalid choice." -ForegroundColor Red
                Stop-Screen
            }
        }
    } 
}

function Start-HashMenu {
    while ($true) {
        Show-HashMainMenu
        $choice = Read-Host "Choose an option"
        switch ($choice) {
            "1" {
                Get-HashCheckCopy
                Write-Log "Choice 1 selected : Hash Check Copy"
            }
            "2" {
                Get-HashCheckVerify
                Write-Log "Choice 2 selected : Hash Check Verify"
            }
            "3" {
                Get-HashCheckRemove
                Write-Log "Choice 3 selected : Hash Check Remove"
            }
            "0" { return }
            default {
                Write-Host "Invalid choice." -ForegroundColor Red
                Write-ErrorLog -Source "Hash Check Menu" -Message "Invalid choice : $choice" -Silent
                Stop-Screen
            }
        }
    }
}

function Start-Git {
    do {
        Show-GitMenu
        $choice = Read-Host "Choose an option"
        switch ($choice) {
            "1" { Install-Git }
            "2" { Search-InstallGit; Clone-Repo }
            "3" { Search-InstallGit; Remove-Repo }
            "0" {
                Clear-Host
                return
            }
            default {
                Write-Host "Invalid choice." -ForegroundColor Red
                Pause
            }
        }
    } until ($choice -eq "0")
}

function Start-WingetMenu {
    do {
        Clear-Host
        Show-WingetMenu
        $choice = Read-Host "Choose an option"
        switch ($choice) {
            "1" { Install-Menu }
            "2" {

            }
            "3" {

            }
            "4" {

            }
            "0" {
                Clear-Host
                return
            }
            default {
                Write-Host "Invalid choice." -ForegroundColor Red
            }
        }
    } until ($choice -eq "0")
}