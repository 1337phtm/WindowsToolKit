. $PSScriptRoot\..\Setup.ps1 -LogName $PSCommandPath
function Remove-Repo {

    Clear-Host
    Show-SectionHeader "Git Remove"

    function Find-repo {

        # Dossiers à exclure
        $exclude = @(
            "$env:WINDIR",
            "C:\Windows",
            "C:\Program Files",
            "C:\Program Files (x86)",
            "C:\inetpub",
            "C:\PerfLogs"
            "C:\ProgramData"
        )

        $drives = Get-PSDrive -PSProvider FileSystem
        $allRepos = @()

        Write-Status INFO "Searching for git repositories (this action may take some time)..."
        foreach ($drive in $drives) {
            # Vérifie si le disque doit être exclu
            if ($exclude -contains $drive.Root.TrimEnd("\")) {
                Write-Status SKIP "Skipping excluded drive $($drive.Root)"
                continue
            }
            try {
                $repos = Get-ChildItem `
                    -Path $drive.Root `
                    -Directory `
                    -Filter ".git" `
                    -Recurse `
                    -Force `
                    -ErrorAction SilentlyContinue

                foreach ($folder in $repos) {
                    if ($folder.Parent) {
                        # Vérifie qu’il y a bien un parent
                        $allRepos += $folder.Parent.FullName  # Ajoute le chemin du repo
                    }
                }
            }
            catch {
                # accès refusé : ignoré
            }
        }

        Write-Host ""
        Write-Status INFO "Found $($allRepos.Count) Git repositories :"
        Write-Host ""

        for ($i = 0; $i -lt $allRepos.Count; $i++) {
            Write-Status INFO "[$($i+1)] $($allRepos[$i])"
            Write-Host ""

            #Suppression des dossiers
            $repo = $allRepos[$i]
            $num = $i + 1  # numéro humain (1,2,3...)

            $choice = Read-Host "[$num/$($allRepos.Count)] Do you want to delete $repo ? (Y/N)"
            Write-Host ""

            if ($choice -in @("Y", "y")) {
                Remove-Item -Path $repo -Recurse -Force
                Write-Status SUCCESS "Deletion of $repo successful."
                Write-Host ""
            }
        }
    }

    Find-repo
    Pause
    Clear-Host
}

Export-ModuleMember -Function Remove-Repo
