# Troubleshooting

## User cannot log on
1. Account enabled? Locked? Expired?
2. Correct domain / UPN suffix?
3. DC reachable? `nltest /dsgetdc:contoso.local`
4. Time skew > 5 minutes? Kerberos fails
5. Logon hours / workstation restrictions

## GPO not applying
```powershell
gpresult /r
gpresult /h C:\Temp\gp.html
Get-GPOReport -All -ReportType Html -Path C:\Temp\all-gpos.html
```
Check: link enabled, security filtering, WMI filter, inheritance block, replication

## Replication
```powershell
repadmin /replsummary
repadmin /showrepl
dcdiag /v
```

## DNS
```powershell
dcdiag /test:dns
Resolve-DnsName _ldap._tcp.dc._msdcs.contoso.local -Type SRV
```
