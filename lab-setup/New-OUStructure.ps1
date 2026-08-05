<#
.SYNOPSIS
    Creates the Corp OU skeleton for the contoso.local lab.
#>
[CmdletBinding()]
param(
    [string]$DomainDN = 'DC=contoso,DC=local'
)

$ErrorActionPreference = 'Stop'
Import-Module ActiveDirectory

function Ensure-OU {
    param([string]$Name, [string]$Path)
    $dn = "OU=$Name,$Path"
    if (-not (Get-ADOrganizationalUnit -Filter "distinguishedName -eq '$dn'" -ErrorAction SilentlyContinue)) {
        New-ADOrganizationalUnit -Name $Name -Path $Path -ProtectedFromAccidentalDeletion $true
        Write-Host "Created $dn"
    } else {
        Write-Host "Exists  $dn"
    }
}

Ensure-OU -Name 'Corp' -Path $DomainDN
Ensure-OU -Name 'Users' -Path "OU=Corp,$DomainDN"
Ensure-OU -Name 'HR' -Path "OU=Users,OU=Corp,$DomainDN"
Ensure-OU -Name 'IT' -Path "OU=Users,OU=Corp,$DomainDN"
Ensure-OU -Name 'Finance' -Path "OU=Users,OU=Corp,$DomainDN"
Ensure-OU -Name 'Workstations' -Path "OU=Corp,$DomainDN"
Ensure-OU -Name 'Servers' -Path "OU=Corp,$DomainDN"
Ensure-OU -Name 'ServiceAccounts' -Path "OU=Corp,$DomainDN"
Ensure-OU -Name 'Groups' -Path $DomainDN
Ensure-OU -Name 'Security' -Path "OU=Groups,$DomainDN"
Ensure-OU -Name 'Distribution' -Path "OU=Groups,$DomainDN"
Ensure-OU -Name 'Quarantine' -Path $DomainDN

# Baseline security groups
$groups = @(
    @{Name='SG-HR';OU="OU=Security,OU=Groups,$DomainDN"},
    @{Name='SG-IT';OU="OU=Security,OU=Groups,$DomainDN"},
    @{Name='SG-Finance';OU="OU=Security,OU=Groups,$DomainDN"},
    @{Name='SG-HelpDesk-L1';OU="OU=Security,OU=Groups,$DomainDN"},
    @{Name='SG-Workstation-Admins';OU="OU=Security,OU=Groups,$DomainDN"}
)
foreach ($g in $groups) {
    if (-not (Get-ADGroup -Filter "Name -eq '$($g.Name)'" -ErrorAction SilentlyContinue)) {
        New-ADGroup -Name $g.Name -GroupScope Global -GroupCategory Security -Path $g.OU
        Write-Host "Created group $($g.Name)"
    }
}

Write-Host 'OU structure complete.'
