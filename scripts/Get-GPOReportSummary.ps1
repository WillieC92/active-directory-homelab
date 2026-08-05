<#
.SYNOPSIS
    Lists GPOs with link count and status for documentation/audits.
#>
[CmdletBinding()]
param(
    [string]$OutputPath = ".\reports\GPOSummary_$(Get-Date -Format yyyy-MM-dd).csv"
)

Import-Module GroupPolicy -ErrorAction Stop
$gpos = Get-GPO -All | ForEach-Object {
    $links = (Get-GPOReport -Guid $_.Id -ReportType Xml | Select-Xml -XPath '//LinksTo').Node
    [pscustomobject]@{
        DisplayName = $_.DisplayName
        Id          = $_.Id
        GpoStatus   = $_.GpoStatus
        CreationTime= $_.CreationTime
        ModificationTime = $_.ModificationTime
        WmiFilter   = $_.WmiFilter.Name
        LinkCount   = if ($links) { @($links).Count } else { 0 }
    }
}
$gpos | Format-Table -AutoSize
$dir = Split-Path $OutputPath -Parent
if ($dir -and -not (Test-Path $dir)) { New-Item -ItemType Directory -Path $dir | Out-Null }
$gpos | Export-Csv $OutputPath -NoTypeInformation
Write-Host "Wrote $OutputPath"
return $gpos
