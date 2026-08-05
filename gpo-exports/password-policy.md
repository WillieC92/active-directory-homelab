# Password and Lockout Policy

Prefer **Default Domain Policy** (or a dedicated fine-grained PSO for admins).

## Domain password policy (lab baseline)
| Setting | Value |
|---------|-------|
| Enforce password history | 24 |
| Maximum password age | 60 days |
| Minimum password age | 1 day |
| Minimum password length | 12 |
| Password must meet complexity | Enabled |
| Store passwords using reversible encryption | Disabled |

## Account lockout
| Setting | Value |
|---------|-------|
| Account lockout duration | 30 minutes |
| Account lockout threshold | 5 invalid attempts |
| Reset account lockout counter after | 30 minutes |

## Fine-grained PSO suggestion (admin accounts)
- Min length 16
- Max age 30 days
- Applies to `SG-Tier0-Admins` (create when ready)
