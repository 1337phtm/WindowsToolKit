function Start-ToolboxMenu {
    while ($true) {
        Show-ToolboxMenu
        $choice = Read-Host "Select an option"
        switch ($choice) {
            "1" { 
                Get-SystemInfo 
            }
            "2" { 
                Get-FixWin 
            }
            "3" { Get-Diskpart 
            }
            "4" { 
                Get-NetworkTools 
            }
            "0" { return }
            default {
                Write-Status ERROR "Invalid choice."
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
            }
            "2" { 
                Get-CurseforgeBackup 
            }
            "0" { return }
            default {
                Write-Status ERROR "Invalid choice."
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
            }
            "2" {
                Get-HashCheckVerify
            }
            "3" {
                Get-HashCheckRemove
            }
            "0" { return }
            default {
                Write-Status ERROR "Invalid choice."
                Stop-Screen
            }
        }
    }
}

function Start-Git {
    do {
        . $PSScriptRoot\GitInstall\SearchGit.ps1
        Show-GitMenu
        $choice = Read-Host "Choose an option"
        switch ($choice) {
            "1" { Install-Git }
            "2" { Clone-Repo }
            "3" { Remove-Repo }
            "0" {
                Clear-Host
                return
            }
            default {
                Write-Status ERROR "Invalid choice."
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
                Write-Status ERROR "Invalid choice."
            }
        }
    } until ($choice -eq "0")
}