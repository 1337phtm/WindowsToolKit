. $PSScriptRoot\..\Setup.ps1 -LogName $PSCommandPath
function Clone-Repo {
    Clear-Host
    #Search-Git

    Show-SectionHeader "Git Clone"

    $clonePath = "C:\Repos"
    if (-not (Test-Path $clonePath)) {
        New-Item -ItemType Directory -Path $clonePath | Out-Null
    }

    $user = Read-Host "Enter the GitHub username to clone repos from"
    Write-Host ""

    # Correct GitHub API URL
    $repos = Invoke-RestMethod "https://api.github.com/users/$user/repos"

    # Affichage des repos avec numéros
    Write-Status INFO "Available repositories : "
    Write-Host ""

    for ($i = 0; $i -lt $repos.Count; $i++) {
        Write-Status INFO "[$($i+1)] $($repos[$i].name)"

    }
    Write-Host ""

    function Clone-All {
        foreach ($repo in $repos) {

            $target = "$clonePath\$($repo.name)"

            if (Test-Path $target) {
                Write-Status INFO "$($repo.name) already exists. Updating..."
                Write-Host ""
                Set-Location $target
                git pull origin main
                Write-Host ""
                Write-Status SUCCESS "The updating was successful."
            }
            else {
                Write-Status SUCCESS " Cloning $($repo.name)..."
                git clone $repo.clone_url $target
                Write-Host ""
                Write-Status SUCCESS "The cloning was successful at $($target)"
            }

            Write-Host ""
        }

        Pause
    }

    foreach ($repo in $repos) {

        $choice = Read-Host "Do you want to clone $($repo.name) ? (Y/N), all repositories ? (A), or exit [E] "
        Write-Host ""

        if ($choice -in @("A", "a")) {
            Clone-All
            break   # ⬅️ IMPORTANT : on sort de la boucle principale
        }

        if ($choice -in @("E", "e")) {
            return
        }

        if ($choice -in @("Y", "y")) {

            $target = "$clonePath\$($repo.name)"

            if (Test-Path $target) {
                Write-Status INFO "Folder already exists. Updating..."
                Write-Host ""
                Set-Location $target
                git pull origin main
                Write-Host ""
                Write-Status SUCCESS "The updating was successful."
            }
            else {
                Write-Status SUCCESS "Cloning $($repo.name)..."
                Write-Host ""
                git clone $repo.clone_url $target
                Write-Host ""
                Write-Status SUCCESS "The cloning was successful at $($target)"
            }
        }
        else {
            Write-Status SKIP "Skipping $($repo.name)..."
        }
        Write-Host ""
    }

}

Export-ModuleMember -Function Clone-Repo
