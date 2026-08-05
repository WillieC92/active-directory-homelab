<#
.SYNOPSIS
    Moves computer accounts inactive longer than N days into Quarantine OU.
#>
[CmdletBinding(SupportsShouldProcess)]
param(
    [int]$DaysInactive = 90,
    [string]$QuarantineOU = 'OU=Quarantine,DC=contoso,DC=local',
    [switch]$Disable
)

$ErrorActionPreference = 'Stop'
Import-Module ActiveDirectory

$cutoff = (Get-Date).AddDays(-$DaysInactive)
$stale = Get-ADComputer -Filter { Enabled -eq $true } -Properties LastLogonDate |
    Where-Object { -not $_.LastLogonDate -or $_.LastLogonDate -lt $cutoff }

Write-Host "Found $($stale.Count) stale computers"
foreach ($c in $stale) {
    if ($PSCmdlet.ShouldProcess($c.Name, "Move to $QuarantineOU")) {
        if ($Disable) { Disable-ADAccount -Identity $c }
        Move-ADObject -Identity $c.DistinguishedName -TargetPath $QuarantineOU
        Write-Host "Moved $($c.Name)"
    }
}
