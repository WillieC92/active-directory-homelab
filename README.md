# Active Directory Homelab

Hands-on Active Directory Domain Services (AD DS) lab for system administrator portfolios. Covers domain controller promotion, OU design, Group Policy, DNS, DHCP integration concepts, and day-to-day identity administration with PowerShell.

**Skills demonstrated:** Active Directory · Group Policy · DNS · Windows Server · Identity lifecycle · PowerShell · Documentation

---

## Lab Topology

```
┌──────────────────────────────────────────────────┐
│                 contoso.local                     │
│                                                  │
│   DC01 (Windows Server 2022)                     │
│   ├─ AD DS (PDC Emulator FSMO)                   │
│   ├─ DNS                                         │
│   └─ DHCP (optional lab scope)                   │
│                                                  │
│   OU Design:                                     │
│   contoso.local                                  │
│   ├── Corp                                       │
│   │   ├── Users                                  │
│   │   │   ├── HR                                 │
│   │   │   ├── IT                                 │
│   │   │   └── Finance                            │
│   │   ├── Workstations                           │
│   │   ├── Servers                                │
│   │   └── ServiceAccounts                        │
│   ├── Groups                                     │
│   │   ├── Security                               │
│   │   └── Distribution                           │
│   └── Quarantine (stale / disabled objects)      │
└──────────────────────────────────────────────────┘
```

---

## Repository Structure

```
active-directory-homelab/
├── README.md
├── docs/
│   ├── 01-lab-build.md
│   ├── 02-ou-and-delegation.md
│   ├── 03-group-policy.md
│   ├── 04-dns-dhcp.md
│   ├── 05-user-lifecycle.md
│   └── 06-troubleshooting.md
├── lab-setup/
│   ├── New-ADLabDomain.ps1
│   ├── New-OUStructure.ps1
│   └── New-LabUsers.ps1
├── gpo-exports/
│   ├── baseline-workstation.md
│   ├── baseline-server.md
│   └── password-policy.md
└── scripts/
    ├── New-StandardUser.ps1
    ├── Disable-LeaverAccount.ps1
    ├── Move-StaleComputers.ps1
    └── Get-GPOReportSummary.ps1
```

---

## Quick Start (Hyper-V / VMware / VirtualBox)

1. Deploy Windows Server 2022 evaluation VM (2 vCPU, 4 GB RAM, 60 GB disk)  
2. Set static IP, rename host to `DC01`  
3. Run lab setup scripts **as Administrator**:

```powershell
# Promote to domain controller (reboots required)
./lab-setup/New-ADLabDomain.ps1 -DomainName "contoso.local" -NetBIOSName "CONTOSO"

# After reboot — create OU skeleton and sample users
./lab-setup/New-OUStructure.ps1
./lab-setup/New-LabUsers.ps1 -UserCount 25
```

---

## Group Policy Baselines Documented

| GPO | Linked to | Key settings |
|-----|-----------|--------------|
| Baseline - Workstations | Corp\Workstations | Screen lock 15 min, Windows Firewall on, disable guest |
| Baseline - Servers | Corp\Servers | RDP NLA required, audit policy, restrict local logon |
| Password Policy | Domain | 12 chars, complexity, 60-day max age, 24 history |

Full setting tables live under `gpo-exports/`.

---

## Identity Lifecycle Scripts

- **New-StandardUser.ps1** — create user in correct OU, add to dept security group, set temp password + force change  
- **Disable-LeaverAccount.ps1** — disable, reset password, remove group memberships, move to Quarantine OU  
- **Move-StaleComputers.ps1** — relocate computers inactive > N days  

---

## Resume Bullet Examples

- Built an Active Directory homelab with OU design, Group Policy baselines, and DNS on Windows Server 2022  
- Automated user onboarding and offboarding workflows with PowerShell (OU placement, groups, quarantine)  
- Documented GPO baselines for workstations and servers including password and audit policies  

---

## License

MIT
