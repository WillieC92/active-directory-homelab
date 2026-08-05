<#
.SYNOPSIS
    Creates a standard employee AD account in the correct department OU.
#>
[CmdletBinding(SupportsShouldProcess)]
param(
    [Parameter(Mandatory)][string]$FirstName,
    [Parameter(Mandatory)][string]$LastName,
    [Parameter(Mandatory)][ValidateSet('HR','IT','Finance')][string]$Department,
    [string]$Title,
    [string]$ManagerSam,
    [securestring]$TemporaryPassword = (ConvertTo-SecureString 'ChangeMe!OnDay1' -AsPlainText -Force),
    [string]$DomainDN = 'DC=contoso,DC=local'
)

$ErrorActionPreference = 'Stop'
Import-Module ActiveDirectory

$map = @{
    HR      = @{ OU = "OU=HR,OU=Users,OU=Corp,$DomainDN"; Group = 'SG-HR' }
    IT      = @{ OU = "OU=IT,OU=Users,OU=Corp,$DomainDN"; Group = 'SG-IT' }
    Finance = @{ OU = "OU=Finance,OU=Users,OU=Corp,$DomainDN"; Group = 'SG-Finance' }
}

$sam = ($FirstName.Substring(0,1) + $LastName).ToLower() -replace '[^a-z0-9]',''
# ensure uniqueness
$base = $sam; $n = 1
while (Get-ADUser -Filter "SamAccountName -eq '$sam'" -ErrorAction SilentlyContinue) {
    $n++; $sam = "$base$n"
}

$ou = $map[$Department].OU
$group = $map[$Department].Group

if ($PSCmdlet.ShouldProcess($sam, "Create user in $ou")) {
    $params = @{
        Name                  = "$FirstName $LastName"
        GivenName             = $FirstName
        Surname               = $LastName
        SamAccountName        = $sam
        UserPrincipalName     = "$sam@contoso.local"
        Path                  = $ou
        Department            = $Department
        AccountPassword       = $TemporaryPassword
        ChangePasswordAtLogon = $true
        Enabled               = $true
    }
    if ($Title) { $params['Title'] = $Title }
    New-ADUser @params
    Add-ADGroupMember -Identity $group -Members $sam
    if ($ManagerSam) {
        $mgr = Get-ADUser $ManagerSam
        Set-ADUser -Identity $sam -Manager $mgr
    }
    Write-Host "Created $sam ($FirstName $LastName) in $Department"
    Get-ADUser $sam -Properties Department,Title,Manager
}
