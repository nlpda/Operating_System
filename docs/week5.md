---
title: Week 5 — Advanced Security & Monitoring
---

## Objectives
- Enable MAC (SELinux/AppArmor) and document enforcement.
- Enable automatic security updates.
- Configure fail2ban for SSH (and other exposed services if used).
- Build security baseline script (`scripts/security-baseline.sh`).
- Build remote monitoring script (`scripts/monitor-server.sh`).

## Deliverables
- Access control evidence: status commands, policy reports.
- Auto-update evidence: config file snippets and logs.
- fail2ban evidence: jail config, status, sample ban logs.
- Scripts with line-by-line comments and demo outputs.

## Notes and evidence
- AppArmor: `sudo aa-status`; SELinux: `getenforce`, `semanage boolean -l` (if available).
- Auto updates (Ubuntu): `sudo apt install unattended-upgrades`, verify `/etc/apt/apt.conf.d/50unattended-upgrades`.
- fail2ban: `/etc/fail2ban/jail.local` with `[sshd]` enabled; show `sudo fail2ban-client status sshd`.
- `security-baseline.sh` checks: SSH config, firewall rules, MAC status, auto updates, fail2ban state, auditing of users/sudoers, kernel params (optional).
- `monitor-server.sh` collects metrics over SSH and appends to CSV for Week 6 analysis.

## Reflection
- What controls required exceptions? (e.g., allowing workstation IPs).
- How do auto updates and MAC impact performance? Note any measurable overhead.
- Plan Week 6 test runs (duration, intervals, data storage).

---
[← Week 4](week4.md) | [Home](index.md) | [Week 6 →](week6.md)
