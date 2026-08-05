<#
.SYNOPSIS
    Offboards a user: disable, reset password, strip groups, move to Quarantine.
#>
[CmdletBinding(SupportsShouldProcess, ConfirmImpact = 'High')]
param(
    [Parameter(Mandatory)][string]$Identity,
    [string]$QuarantineOU = 'OU=Quarantine,DC=contoso,DC=local',
    [string]$TicketNumber
)

$ErrorActionPreference = 'Stop'
Import-Module ActiveDirectory

$user = Get-ADUser -Identity $Identity -Properties MemberOf, DistinguishedName
$randomPwd = ConvertTo-SecureString (([guid]::NewGuid().Guid) + 'Aa1!') -AsPlainText -Force

if ($PSCmdlet.ShouldProcess($user.SamAccountName, 'Disable and quarantine leaver account')) {
    Disable-ADAccount -Identity $user
    Set-ADAccountPassword -Identity $user -NewPassword $randomPwd -Reset
    Set-ADUser -Identity $user -ChangePasswordAtLogon $false -Description ("Disabled {0:yyyy-MM-dd} Ticket:{1}" -f (Get-Date), $TicketNumber)

    $user.MemberOf | ForEach-Object {
        # Keep Domain Users (primary); remove others
        $g = Get-ADGroup $_
        if ($g.Name -ne 'Domain Users') {
            Remove-ADGroupMember -Identity $g -Members $user -Confirm:$false
            Write-Host "Removed from $($g.Name)"
        }
    }

    Move-ADObject -Identity $user.DistinguishedName -TargetPath $QuarantineOU
    Write-Host "Quarantined $($user.SamAccountName)"
}
