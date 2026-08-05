# OU Design and Delegation

## Structure
```
DC=contoso,DC=local
└── OU=Corp
    ├── OU=Users
    │   ├── OU=HR
    │   ├── OU=IT
    │   └── OU=Finance
    ├── OU=Workstations
    ├── OU=Servers
    └── OU=ServiceAccounts
├── OU=Groups
│   ├── OU=Security
│   └── OU=Distribution
└── OU=Quarantine
```

## Why this layout
- **Department user OUs** — scoped GPOs and clearer ownership  
- **Workstations vs Servers** — different baselines  
- **ServiceAccounts** — no interactive logon; audited  
- **Quarantine** — disabled/stale objects awaiting deletion  

## Delegation examples (help desk)
| Group | Rights | OU |
|-------|--------|-----|
| Help Desk L1 | Reset password, unlock | Corp\Users\* |
| Help Desk L2 | Create/disable users | Corp\Users\* |
| Workstation Admins | Join computers | Corp\Workstations |

Use **Delegate Control** wizard or `dsacls` — document every delegation in change control.
