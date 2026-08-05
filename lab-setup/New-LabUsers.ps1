<#
.SYNOPSIS
    Creates sample department users for lab demos and script testing.
#>
[CmdletBinding()]
param(
    [int]$UserCount = 25,
    [string]$DomainDN = 'DC=contoso,DC=local',
    [securestring]$DefaultPassword = (ConvertTo-SecureString 'ChangeMe!Lab2026' -AsPlainText -Force)
)

$ErrorActionPreference = 'Stop'
Import-Module ActiveDirectory

$departments = @(
    @{ Name = 'HR';      OU = "OU=HR,OU=Users,OU=Corp,$DomainDN";      Group = 'SG-HR' },
    @{ Name = 'IT';      OU = "OU=IT,OU=Users,OU=Corp,$DomainDN";      Group = 'SG-IT' },
    @{ Name = 'Finance'; OU = "OU=Finance,OU=Users,OU=Corp,$DomainDN"; Group = 'SG-Finance' }
)

$first = @('Alex','Jordan','Taylor','Morgan','Casey','Riley','Avery','Quinn','Jamie','Cameron')
$last  = @('Smith','Johnson','Williams','Brown','Jones','Garcia','Miller','Davis','Wilson','Moore')

for ($i = 1; $i -le $UserCount; $i++) {
    $dept = $departments[($i - 1) % $departments.Count]
    $f = $first[($i - 1) % $first.Count]
    $l = $last[($i * 3) % $last.Count]
    $sam = ("{0}{1}{2}" -f $f.Substring(0,1).ToLower(), $l.ToLower(), $i)
    if (Get-ADUser -Filter "SamAccountName -eq '$sam'" -ErrorAction SilentlyContinue) { continue }

    New-ADUser -Name "$f $l" `
        -GivenName $f `
        -Surname $l `
        -SamAccountName $sam `
        -UserPrincipalName "$sam@contoso.local" `
        -Path $dept.OU `
        -Department $dept.Name `
        -AccountPassword $DefaultPassword `
        -ChangePasswordAtLogon $true `
        -Enabled $true

    Add-ADGroupMember -Identity $dept.Group -Members $sam
    Write-Host "Created $sam in $($dept.Name)"
}
Write-Host "Lab users created (password is lab-only; force change on logon)."
