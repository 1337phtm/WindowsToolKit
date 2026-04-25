# HashCheck.psm1
# Outils de hash (comparaison, copie, etc.)

function Show-HashCheck {
    Write-Host "╔══════════════════════════════════════╗" -ForegroundColor Magenta
    Write-Host "║              Hash Check              ║" -ForegroundColor Magenta
    Write-Host "╚══════════════════════════════════════╝" -ForegroundColor Magenta
    Write-Host ""
}

#======================================================================
# Fonctions de base
#======================================================================

#Fonction select dossier via fenêtre
function Select-Folder($message) {

    $FolderBrowser = New-Object -ComObject Shell.Application
    $Folder = $FolderBrowser.BrowseForFolder(0, $message, 0, 0)
    if ($Folder) {
        return $Folder.Items().Item().Path
    }
    else {
        Write-ErrorLog -Source "HASH CHECK | SELECTFOLDER" -Message "User canceled folder selection" -Silent
        return "CANCELED"
    }
}


# Fonction pour copier les fichiers sans écraser
function Copy-Unique($files, $destination) {
    foreach ($file in $files) {
        $destPath = Join-Path $destination $file.Name
        $counter = 1
        while (Test-Path $destPath) {
            $base = [System.IO.Path]::GetFileNameWithoutExtension($file.Name)
            $ext = [System.IO.Path]::GetExtension($file.Name)
            $destPath = Join-Path $destination ("$base" + "_$counter" + "$ext")
            $counter++
        }
        Copy-Item $file.Path -Destination $destPath
    }
}



#======================================================================
# HashCheck Copy
#======================================================================

function Get-HashCheckCopy {

    Clear-Host
    Show-HashCheck

    # Demander combien de dossiers comparer
    [int]$nbFolders = Read-Host "How many repertory do you want to compare ? "

    if ($nbFolders -lt 2) {
        Write-Host ""
        Write-Host "You need at least 2 cases to compare." -ForegroundColor Red
        Write-Host ""
        Write-ErrorLog -Source "HASH CHECK | SELECTFOLDER" -Message "User choose less than 2 cases to compare." -Silent
        Pause
        return
    }

    # Sélectionner les dossiers sources
    $folders = @()
    for ($i = 1; $i -le $nbFolders; $i++) {
        $folder = Select-Folder "Choose the folder number $i : "
        if ($folder -eq "CANCELED") {
            return  # ← quitte la fonction appelante immédiatement
        }
        $folders += $folder
    }

    # Sélectionner le dossier final
    $finalFolder = Select-Folder "Choose the final folder : "
    if ($finalFolder -eq "CANCELED") {
        return  # ← quitte la fonction appelante immédiatement
    }

    # Récupérer les fichiers et leurs hash pour chaque dossier
    $allHashes = @()
    foreach ($folder in $folders) {
        $hashes = Get-ChildItem $folder -File -Recurse | ForEach-Object {
            [PSCustomObject]@{
                Path = $_.FullName
                Name = $_.Name
                Hash = (Get-FileHash $_.FullName -Algorithm SHA256).Hash
            }
        }
        $allHashes += $hashes
    }

    # Trouver les fichiers uniques (hash apparaissant une seule fois)
    $uniqueFiles = $allHashes | Group-Object Hash | Where-Object { $_.Count -eq 1 } | ForEach-Object { $_.Group }


    # Copier les fichiers uniques
    Copy-Unique $uniqueFiles $finalFolder

    Write-Host ""
    Write-Output "All unique files have been copied into $finalFolder."
    Write-Host ""

    Invoke-Item $finalFolder
}

#======================================================================
# HashCheck Verify
#======================================================================

function Get-HashCheckVerify {

    Clear-Host
    Show-HashCheck

    # Demander combien de dossiers comparer
    [int]$nbFolders = Read-Host "How many repertory do you want to compare ? "

    if ($nbFolders -lt 2) {
        Write-Host ""
        Write-Host "You need at least 2 cases to compare." -ForegroundColor Red
        Write-Host ""
        Write-ErrorLog -Source "HASH CHECK | SELECTFOLDER" -Message "User choose less than 2 cases to compare." -Silent
        Pause
        return
    }

    # Sélectionner les dossiers sources
    $folders = @()
    for ($i = 1; $i -le $nbFolders; $i++) {
        $folder = Select-Folder "Choose the folder number $i : "
        if ($folder -eq "CANCELED") {
            return  # ← quitte la fonction appelante immédiatement
        }
        $folders += $folder
    }

    # Récupérer les fichiers et leurs hash pour chaque dossier
    $allHashes = @()
    foreach ($folder in $folders) {
        $hashes = Get-ChildItem $folder -File -Recurse | ForEach-Object {
            [PSCustomObject]@{
                Path          = $_.FullName
                Name          = $_.Name
                Hash          = (Get-FileHash $_.FullName -Algorithm SHA256).Hash
                Size          = $_.Length
                LastWriteTime = $_.LastWriteTime
                #ShortPath     = $_.DirectoryName.Split('\')[-1] + "\" + $_.Name
            }
        }
        $allHashes += $hashes
    }

    # Trouver les fichiers uniques (hash apparaissant une seule fois)
    $uniqueFiles = $allHashes | Group-Object Hash | Where-Object { $_.Count -eq 1 } | ForEach-Object { $_.Group }

    Write-Host ""
    #Write-Output $uniqueFiles | Format-Table Name, Size, LastWriteTime, Path -AutoSize #ShortPath
    Write-Output $uniqueFiles | Format-Table ` @{Label = "LastWrite"; Expression = { $_.LastWriteTime }; Width = 22 }, @{Label = "Name"; Expression = { $_.Name }; Width = 25 }, @{Label = "Size"; Expression = { $_.Size }; Width = 10 }, @{Label = "Path"; Expression = { $_.Path }; Width = 80 }
    Write-Host ""

    Stop-Screen

}

#======================================================================
# HashCheck Remove
#======================================================================

function Get-HashCheckRemove {
}

#======================================================================
# Export
#======================================================================

Export-ModuleMember -Function *-*
