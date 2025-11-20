---
title: Week 2 — Security Planning & Testing Methodology
---

## Objectives
- Draft performance testing approach for remote monitoring.
- Build a security configuration checklist before touching the server.
- Produce a threat model with at least three concrete threats + mitigations.

## Deliverables
- Performance testing plan: metrics, tools, sampling intervals, automation plan.
- Security checklist: SSH hardening, firewall defaults, MAC (SELinux/AppArmor), updates, privilege mgmt.
- Threat model: actors, attack surfaces, mitigations.

## Notes and evidence
- Planned metrics: CPU, RAM, disk I/O, network throughput/latency, process responsiveness.
- Remote monitoring approach: `ssh user@server "vmstat 5 5"`, `sar`, `iostat`, `ss -tulpn`, `journalctl`.
- Security checklist examples:
  - Key-based SSH, disable password/RootLogin, `AllowUsers <admin-user>`.
  - Firewall allowlist: SSH from workstation IP only (`ufw allow from 192.168.56.1 to any port 22 proto tcp`).
  - Automatic updates on (e.g., `unattended-upgrades`).
  - MAC: AppArmor enabled (Ubuntu) or SELinux enforcing (RHEL/Fedora/Rocky).
  - fail2ban planned jails: `sshd`, optional `nginx`.
  - Non-root admin user with sudo, passwordless sudo disabled unless justified.
- Threats and mitigations (examples):
  - Stolen SSH key → protect with passphrase, limit source IP, use `Fail2ban`.
  - Port scanning → firewall default deny, nmap verification, only required services exposed.
  - Misconfigured services → service inventory + hardening, configuration diff tracked in git.

## Reflection
- Gaps in tools? (Install `sysstat`, `iostat`, `iftop` on workstation.)
- How will evidence be captured? (screenshots with prompts, saved logs in `data/`.)
- Confirm commands you will demo live in the final video.

---
[← Week 1](week1.md) | [Home](index.md) | [Week 3 →](week3.md)
