# User Lifecycle

## Onboarding
1. HR ticket with name, department, start date, manager, title
2. `New-StandardUser.ps1` creates account in correct OU
3. Add to department security group + baseline app groups
4. Set temporary password; **Change password at next logon**
5. License assignment (M365) — outside pure AD lab scope
6. Confirm first logon / MFA registration day 1

## Offboarding
1. Disable account immediately on last day (or sooner if risk)
2. `Disable-LeaverAccount.ps1` — reset pwd, clear groups, move to Quarantine
3. Hide from address book (if mail-enabled)
4. Convert mailbox per retention policy
5. After retention, delete object

## Access reviews
- Quarterly group membership export (`Export-GroupMembership` from toolkit repo)
- Manager attestation for high-privilege groups
