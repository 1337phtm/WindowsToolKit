$Global:ErrorActionPreference = "Stop"

#======================================================================
# Importation des modules
#======================================================================
Import-Module "$PSScriptRoot\module\searchgit.psm1" -Force -DisableNameChecking
Import-Module "$PSScriptRoot\module\clonerepo.psm1" -Force -DisableNameChecking
Import-Module "$PSScriptRoot\module\removerepo.psm1" -Force -DisableNameChecking


Export-ModuleMember -Function *-*
