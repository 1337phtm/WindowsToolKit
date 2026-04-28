. $PSScriptRoot\..\Setup.ps1 -LogName $PSCommandPath

Show-SectionHeader "Search Git"

try {
    $gitCmd = Get-Command git -ErrorAction SilentlyContinue

    if (-not $gitCmd) {
        Write-Status INFO "Git is not installed."
        Write-Host ""
        $choice = Read-Host "Do you want to install Git now ? (Y/N)"
        Write-Host ""

        if ($choice -in @("Y", "y")) {
            Write-Status INFO "Installing Git..."
            winget install --id Git.Git -e --source winget

            # Reload PATH
            $env:Path = [System.Environment]::GetEnvironmentVariable("Path", "Machine") + ";" +
            [System.Environment]::GetEnvironmentVariable("Path", "User")

            Write-Host ""
            Write-Status SUCCESS "Git has been installed successfully."
            Write-Host ""
        }
        else {
            Write-Status SKIP "⚠  Git installation skipped. The script cannot continue."
            Pause
            return
        }
    }
}
catch {
    Write-Status ERROR "Error while checking Git installation."
    return
}
Clear-Host
