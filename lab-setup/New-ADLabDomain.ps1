<#
.SYNOPSIS
    Installs AD DS and creates a new lab forest.
#>
[CmdletBinding(SupportsShouldProcess)]
param(
    [string]$DomainName = 'contoso.local',
    [string]$NetBIOSName = 'CONTOSO',
    [Parameter(Mandatory)]
    [SecureString]$SafeModeAdministratorPassword
)

$ErrorActionPreference = 'Stop'
$features = @('AD-Domain-Services','DNS','GPMC','RSAT-AD-Tools')
foreach ($f in $features) {
    if (-not (Get-WindowsFeature $f).Installed) {
        Install-WindowsFeature $f -IncludeManagementTools | Out-Null
        Write-Host "Installed $f"
    }
}

Import-Module ADDSDeployment
if ($PSCmdlet.ShouldProcess($DomainName, 'Install-ADDSForest')) {
    Install-ADDSForest `
        -DomainName $DomainName `
        -DomainNetbiosName $NetBIOSName `
        -SafeModeAdministratorPassword $SafeModeAdministratorPassword `
        -InstallDns `
        -Force `
        -NoRebootOnCompletion:$false
}
