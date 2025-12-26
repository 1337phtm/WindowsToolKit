# HashCheck.psm1
# Outils de hash (comparaison, copie, etc.)

function Show-HashMainMenu {
    Clear-Host
    Write-Host "============================="
    Write-Host "        HASH CHECK"
    Write-Host "============================="
    Write-Host "1 - Hash Check Copy"
    Write-Host "2 - Hash Check Verify"
    Write-Host "3 - Hash Check Remove"
    Write-Host "0 - Exit"
    Write-Host "============================="
}

function Start-HashMenu {
    do {
        Show-HashMainMenu
        $choice = Read-Host "Choose an option"

        switch ($choice) {
            "1" { # HashCheckCopy à implémenter
            }
            "2" { # HashCheckVerify à implémenter
            }
            "3" { # HashCheckRemove à implémenter
            }
            "0" { Clear-Host }
            default { Clear-Host }
        }
    } until ($choice -eq "0")
}

Export-ModuleMember -Function *-*
