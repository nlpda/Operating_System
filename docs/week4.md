---
title: Week 4 — Initial Configuration & Security Implementation
---

## Objectives
- Configure SSH key-based access; disable password auth.
- Configure firewall permitting SSH only from workstation IP.
- Create non-root admin user with least privilege.
- Document before/after configs and remote evidence.

## Deliverables
- SSH config evidence: `/etc/ssh/sshd_config` diff, `sshd` reload output.
- Firewall ruleset: `ufw status numbered` or `firewall-cmd --list-all`.
- User/privilege setup: `adduser`, `usermod -aG sudo <user>`, `/etc/sudoers.d/<user>`.
- Remote evidence: screenshots of SSH session from workstation.
- Remote administration proof: commands executed via SSH (no local console).

## Key commands (examples)
```bash
# On server (over SSH)
sudo ssh-keygen -A
sudo cp ~/.ssh/authorized_keys /root/.ssh/authorized_keys
sudoedit /etc/ssh/sshd_config  # PermitRootLogin no, PasswordAuthentication no, AllowUsers <admin>
sudo systemctl restart sshd

sudo ufw default deny incoming
sudo ufw allow from 192.168.56.1 to any port 22 proto tcp
sudo ufw enable

sudo adduser <admin>
sudo usermod -aG sudo <admin>
sudo visudo -f /etc/sudoers.d/<admin>  # Defaults requiretty? (distro-specific)
```

## Evidence collection
- Capture `sshd_config` before/after (`diff -u`).
- Record `ufw status numbered` / `iptables -S` outputs.
- Screenshot successful SSH login with `whoami`, `hostname`, `ip addr`.

## Reflection
- Any lockouts? Document recovery steps.
- Why these firewall rules and not broader?
- What changed in attack surface vs Week 1?

---
[← Week 3](week3.md) | [Home](index.md) | [Week 5 →](week5.md)
