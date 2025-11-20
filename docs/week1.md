---
title: Week 1 — System Planning & Distribution Selection
---

## Objectives
- Choose server and workstation setup (VirtualBox network plan, IPs, SSH access path).
- Compare at least two server distributions and justify the chosen one.
- Baseline hardware/software info via CLI only.
- Produce a simple architecture diagram (server + workstation + network).

## Deliverables
- Architecture diagram (`docs/assets/architecture-week1.png` placeholder — replace with your diagram).
- Distribution selection justification (e.g., Ubuntu Server vs Debian vs Rocky).
- Workstation choice (Option A/B/C) rationale.
- Network configuration: VirtualBox NIC mode, host-only network details, IP plan.
- CLI evidence: `uname -a`, `lsb_release -a`, `free -h`, `df -h`, `ip addr`, `ip route`.

## Notes and evidence
- Chosen server distro: **[replace with distro/version]** because **[stability/support/long-term updates/tooling]**.
- Workstation approach: **[Option A/B/C]**; SSH key storage path **[~/.ssh/id_ed25519]**.
- Network: Host-only `192.168.56.0/24`, static server IP `192.168.56.10`, workstation `192.168.56.1`.
- Commands run (examples):
  ```bash
  uname -a
  lsb_release -a
  free -h
  df -h
  ip addr show
  ip route show
  ```

## Reflection
- What trade-offs drove the distro choice (package availability vs minimal footprint)?
- Any networking hurdles (DHCP vs static IP, NAT vs host-only)?
- Next steps: prepare security checklist and testing plan for Week 2.

---
[Home](index.md) | [Week 2 →](week2.md)
