# ZipArchive.psm1
# Gestion des sauvegardes / archives

function Show-ZipMenu {
    Clear-Host
    Write-Host "============================="
    Write-Host "       ZIP ARCHIVE"
    Write-Host "============================="
    Write-Host "1 - Archive Zip"
    Write-Host "2 - Archive CurseForge"
    Write-Host "0 - Exit"
    Write-Host "============================="
}

function Start-ZipMenu {
    do {
        Show-ZipMenu
        $choice = Read-Host "Choose an option"

        switch ($choice) {
            "1" { # Get-ArchiveBackup à implémenter
            }
            "2" { # Get-CurseforgeBackup à implémenter
            }
            "0" { Clear-Host }
            default { Clear-Host }
        }
    } until ($choice -eq "0")
}

Export-ModuleMember -Function *-*
