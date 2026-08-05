# GPO: Baseline - Servers

**Link:** OU=Servers,OU=Corp

| Path | Setting | Value |
|------|---------|-------|
| Remote Desktop Services → Security → Require user authentication for remote connections by using Network Level Authentication | Enabled | |
| Remote Desktop Services → Security → Set client connection encryption level | High | |
| Windows Firewall → Domain profile | On | |
| Audit Policy (Advanced) → Account Logon → Audit Credential Validation | Success and Failure | |
| Audit Policy → Account Management → Audit User Account Management | Success and Failure | |
| Audit Policy → Logon/Logoff → Audit Logon | Success and Failure | |
| Security Options → Interactive logon: Do not require CTRL+ALT+DEL | Disabled | |
| User Rights → Allow log on locally | Administrators only | |
| User Rights → Allow log on through Remote Desktop Services | Administrators (+ jump group if used) | |
| System Services → Print Spooler | Disabled (non-print servers) | |

## Notes
- Do not apply workstation-only settings that break service accounts
- Test on a single server OU first
