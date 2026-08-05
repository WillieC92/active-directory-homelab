# GPO: Baseline - Workstations

**Link:** OU=Workstations,OU=Corp  
**Security filtering:** Authenticated Users (or sg-devices-workstations)

| Path | Setting | Value |
|------|---------|-------|
| Computer Config → Windows Settings → Security Settings → Local Policies → Security Options → Interactive logon: Machine inactivity limit | 900 seconds | |
| Administrative Templates → System → Power Management → Video and Display Settings → Turn off the display (plugged in) | 15 minutes | |
| Windows Components → Windows Logon Options → Disable app notifications on lock screen | Enabled | |
| Network → Network Connections → Windows Defender Firewall → Protect all network connections | Enabled (all profiles) | |
| System → Logon → Do not display last signed-in | Enabled | |
| Windows Components → Windows Update → Configure Automatic Updates | Enabled - Auto download and schedule | |
| Security Options → Accounts: Guest account status | Disabled | |
| Security Options → Network access: Do not allow anonymous enumeration of SAM accounts | Enabled | |
| Administrative Templates → Windows Components → Remote Desktop Services → Connections → Allow users to connect remotely | Disabled (unless help desk jump hosts) | |

Export tip: after creating in lab, `Backup-GPO -Name 'Baseline - Workstations' -Path .\gpo-exports\backups`
