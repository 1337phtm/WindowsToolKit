#20252112 18:38 1337phtm 

#Usefull
#R00

#R01 Main Setup----------------------------------------------------------------------------------------------------------------------------------------

function Programs { #R1 Programs
do {
    Clear-Host
    Get-ShowMenu
    $choix = Read-Host "Choose an option"
    switch ($choix) 
    {
        "1" { Toolbox }
        "2" { ZipArchive }
        "3" { HashCheck }
        "0" {
        Write-Host ""  
        Write-Host "Closing program"
        Write-Host "" 
        Clear-Host
        }
        default { Clear-Host }
    }
}until ($choix -eq "0")
}

#R02 Main Show-----------------------------------------------------------------------------------------------------------------------------------------

function Get-ShowMenu { #R1 Show main menu
    Write-Host "============================="
    Write-Host "       WINDOWS USEFULL"
    Write-Host "    Written by Phantom__m"
    Write-Host "============================="
    Write-Host "1 - Toolbox"
    Write-Host "2 - Zip archive"
    Write-Host "3 - Hash Check"
    Write-Host "0 - Exit"
    Write-Host "============================="
}

#R03 Functions-----------------------------------------------------------------------------------------------------------------------------------


function ZipArchive { #R20 : Start ZipArchive

#-------------------------------------------------------------------------------------------------------------------Setup-----------------------------------------------------------------------------------------------------------------------------------------

#Programs :
function Programs {
do {
    Clear-Host
    Get-ShowMenu
    $choix = Read-Host "Choisissez une option"
    switch ($choix) 
    {
        "1" { Get-Archivebackup }
        "2" { Get-Curseforgebackup }
        "0" { Clear-Host }
        default { Clear-Host }
    }
}until ($choix -eq "0")
}

#-------------------------------------------------------------------------------------------------------------------Show-------------------------------------------------------------------------------------------------------------------------------------------

function Get-ShowMenu {
    Write-Host "============================="
    Write-Host "      TOOLBOX WINDOWS"
    Write-Host "============================="
    Write-Host "1 - Archive Zip"
    Write-Host "2 - Archive curseforge"
    Write-Host "0 - Exit"
    Write-Host "============================="
}

#-----------------------------------------------------------------------------------------------------------------Main Functions----------------------------------------------------------------------------------------------------------------------------------

function Get-Curseforgebackup {
Clear-Host
Write-Host "============================================ Starting curseforge backup ============================================"
Write-Host ""


# --- AUTO-DETECTION DU CHEMIN CURSEFORGE ---
$BasePaths = @(
    "$env:USERPROFILE\CurseForge\Minecraft\Instances\",
    "$env:USERPROFILE\Documents\CurseForge\Minecraft\Instances\",
    "$env:APPDATA\CurseForge\Minecraft\Instances\"
)

# --- RECHERCHE DES INSTANCES ---
$Instances = @()
foreach ($path in $BasePaths) {
    if (Test-Path $path) {
      $Instances += Get-ChildItem -Path $path -Directory | Select-Object -ExpandProperty FullName
    }
}

if (-not $Instances) {
  Write-Host "ERROR : No CurseForge instances found in any known location."
  Write-Host ""
  return
}

# --- AFFICHAGE ET CHOIX ---
Write-Host "Instances found:"
for ($i = 0; $i -lt $Instances.Count; $i++) {
  Write-Host "[$i] $($Instances[$i])"
}

$choice = Read-Host "Enter the number of the instance you want to back up"
if ($choice -notmatch '^\d+$' -or [int]$choice -ge $Instances.Count) {
  Write-Host "Invalid choice. Exiting."
  return
}

$CurseForgePath = $Instances[$choice]
$Profil = Split-Path $CurseForgePath -Leaf


Write-Host ""
Write-Host "Profile selected: $Profil"
Write-Host "Path: $CurseForgePath"
Write-Host ""


# --- CHEMIN DU ZIP ---
$Date = Get-Date -Format "yyyy-MM-dd_HH-mm"
$Output = "$env:USERPROFILE\Desktop\Save_${Profil}_$Date.zip"


Write-Host "Create the zip file in : $Output"
Write-Host ""

Add-Type -AssemblyName System.IO.Compression.FileSystem

try {
  [System.IO.Compression.ZipFile]::CreateFromDirectory($CurseForgePath, $Output)
  Write-Host "Export complete."
  Write-Host "Archive created at: $Output"
}
catch {
  Write-Host "ERROR during archive creation: $_"
}
}

function Get-Archivebackup {
    Clear-Host
    Write-Host "============================================ Starting Archive backup ============================================"
    Write-Host ""

    # Sélecteur de dossier
    function Select-Folder($message) {
        $FolderBrowser = New-Object -ComObject Shell.Application
        $Folder = $FolderBrowser.BrowseForFolder(0, $message, 0, 0)
        if ($Folder) { return $Folder.Items().Item().Path } else { return $null }
    }

    # Choix du nombre de dossiers
    [int]$nbFolders = Read-Host "How many repertory do you want to archive ? "
    if ($nbFolders -lt 1) {
        Write-Host ""
        Write-Host "You need at least 1 case to archive." -ForegroundColor Red
        Write-Host ""
        Pause
        return
    }

    # Sélection et vérification des dossiers
    $folders = @()
    for ($i=1; $i -le $nbFolders; $i++) {
        $folder = Select-Folder "Choose the folder number $i : "
        if (-not $folder) { Write-Host "Selection cancelled." -ForegroundColor Red; return }
        if (!(Test-Path $folder)) { Write-Error "The folder $folder does not exist."; Pause; return }
        $folder = $folder.TrimEnd('\','/')
        $folders += $folder
    }

    # Préparer sortie et staging
    $Date   = Get-Date -Format "yyyy-MM-dd_HH-mm"
    $Output = "$env:USERPROFILE\Desktop\Save_$Date.zip"
    $Stage  = Join-Path $env:TEMP ("$USERPROFILE" + [Guid]::NewGuid().ToString())

    # Incrémentation s'il existe déjà
    $counter = 1
    while (Test-Path $Output) {
        $Output = "$env:USERPROFILE\Desktop\Save_${Date}_$counter.zip"
        $counter++
    }

    # Créer staging
    New-Item -ItemType Directory -Path $Stage | Out-Null

    try {
        foreach ($folder in $folders) {
            $baseName = Split-Path $folder -Leaf
            $target   = Join-Path $Stage $baseName

            Write-Host ">> Copy '$folder' -> '$target'"
            Copy-Item -Path $folder -Destination $target -Recurse -Force
        }

        # Un seul dossier → zip direct du dossier, sinon zip du staging
        if ($folders.Count -eq 1) {
            Compress-Archive -Path (Join-Path $Stage (Split-Path $folders[0] -Leaf)) -DestinationPath $Output -Force
            Write-Host "Archive créée avec le dossier : $($folders[0])"
        } else {
            Compress-Archive -Path $Stage -DestinationPath $Output -Force
            Write-Host "Archive créée avec tous les dossiers choisis."
        }
    }
    catch {
        Write-Host "[ERREUR] Archive backup: $($_.Exception.Message)" -ForegroundColor Red
        throw
    }
    finally {
        # Nettoyer staging
        if (Test-Path $Stage) { Remove-Item $Stage -Force -Recurse }
    }

    Write-Host ""
    Write-Host "Archive finale : $Output"
    Write-Host ""
}




#-------------------------------------------------------------------------------------------------------------------Programme------------------------------------------------------------------------------------------------------------------------------------
Programs
} #R20 : End ZipArchive


function HashCheck{ #R30 : Start HasCheck
#R31 HashCheck Setup----------------------------------------------------------------------------------------------------------------------------------------

function Programs { #R31-1
do {
    Clear-Host
    Show-main
    $choix = Read-Host "Choose an option"
    switch ($choix) 
    {
        "1" { HashCheckCopy }
        "2" { HashCheckVerify }
        "3" { HashCheckRemove }
        "0" {
        Write-Host ""  
        Write-Host "Closing program"
        Write-Host "" 
        Clear-Host
        }
        default { Clear-Host }
    }
}until ($choix -eq "0")
}#End R31-1

#R32 HashCheck Show-----------------------------------------------------------------------------------------------------------------------------------------

function Show-main { #R32-1
    Write-Host "============================="
    Write-Host "        Hash Check"
    Write-Host "============================="
    Write-Host "1 - Hash Check Copy"
    Write-Host "2 - Hash Check Verify"
    Write-Host "3 - Hash Check Remove"
    Write-Host "0 - Exit"
    Write-Host "============================="
}#End R32-1

function Show-HashCheck { #R32-2
    Write-Host "============================="
    Write-Host "         Hash Check"
    Write-Host "============================="
    Write-Host ""
}#End R32-2

#R33 HashCheck Functions-----------------------------------------------------------------------------------------------------------------------------------

function HashCheckCopy { #R33-1
#-------------------------------------------------------------------------------------------------------------------Setup----------------------------------------------------------------------------------------------------------------------------------------

Clear-Host
Show-HashCheck

#-------------------------------------------------------------------------------------------------------------------Functions-----------------------------------------------------------------------------------------------------------------------------------

#Fonction select dossier via fenêtre
function Select-Folder($message) {
    $FolderBrowser = New-Object -ComObject Shell.Application
    $Folder = $FolderBrowser.BrowseForFolder(0, $message, 0, 0)
    if ($Folder) {
        return $Folder.Items().Item().Path
    } else {
        return $null
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

#-------------------------------------------------------------------------------------------------------------------Programme------------------------------------------------------------------------------------------------------------------------------------

# Demander combien de dossiers comparer
[int]$nbFolders = Read-Host "How many repertory do you want to compare ? "

if ($nbFolders -lt 2) {
    Write-Host ""
    Write-Host "You need at least 2 cases to compare." -ForegroundColor Red
    Write-Host ""
    Pause
    return
}

# Sélectionner les dossiers sources
$folders = @()
for ($i=1; $i -le $nbFolders; $i++) {
    $folder = Select-Folder "Choose the folder number $i : "
    if (-not $folder) { 
        Write-Host "Selection cancelled." -ForegroundColor Red
        return
    }
    if (!(Test-Path $folder)) { 
        Write-Error "The folder $folder does not exist."; 
        Pause
        return
    }
    $folders += $folder
}

# Sélectionner le dossier final
$finalFolder = Select-Folder "Choose the final folder : "
if (-not $finalFolder) { 
    Write-Host "Selection cancelled." -ForegroundColor Red
    Pause
    return
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
}#End R33-1

function HashCheckVerify { #R33-2
}#End R33-2

function HashCheckRemove { #R33-3
}#End R33-3

#R34 HashCheck Programs------------------------------------------------------------------------------------------------------------------------------------
Programs
} #R30 : End HasCheck

#R04 Main Program------------------------------------------------------------------------------------------------------------------------------------
Programs