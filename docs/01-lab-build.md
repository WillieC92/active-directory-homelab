# Lab Build

## Hypervisor options
- Hyper-V (Windows Pro/Enterprise)
- VMware Workstation / ESXi
- VirtualBox
- Azure VM (see azure-hybrid-admin-lab for cloud DC)

## DC01 sizing
| Resource | Minimum | Recommended |
|----------|---------|-------------|
| vCPU | 2 | 2 |
| RAM | 4 GB | 6 GB |
| Disk | 60 GB | 80 GB SSD |
| OS | Windows Server 2022 Eval | Same |

## Network
- Host-only or internal virtual switch for isolated lab
- Static IP example: `192.168.56.10/24`
- Gateway optional if you need outbound patching via NAT
- DNS after promo: `127.0.0.1`

## Build steps
1. Install Windows Server 2022 (Desktop Experience for easier learning)
2. Rename computer to `DC01` and reboot
3. Set static IP
4. Run `lab-setup/New-ADLabDomain.ps1`
5. After reboot, run OU + user scripts
