# DNS and DHCP

## DNS (on DC01)
- AD-integrated zones for `contoso.local`
- Secure dynamic updates only
- Forwarders: your lab gateway DNS or `1.1.1.1` / `9.9.9.9` (lab)
- Scavenging: enable with conservative timers after understanding impact

## DHCP (optional lab role)
- Scope: `192.168.56.100 – 192.168.56.200`
- Router option: lab gateway
- DNS option: `192.168.56.10` (DC01)
- Domain name option: `contoso.local`

## Validation
```powershell
Resolve-DnsName dc01.contoso.local
Get-DnsServerZone
Get-DhcpServerv4Scope   # if installed
```
