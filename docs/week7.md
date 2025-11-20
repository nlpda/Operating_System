---
title: Week 7 — Security Audit & System Evaluation
---

## Objectives
- Perform full security audit: Lynis, nmap, access control verification, service inventory.
- Compare Lynis scores before/after remediation.
- Final risk assessment and overall system evaluation.

## Deliverables
- Security Audit Report summary with key findings and evidence.
- Lynis results: command output, score trend, remediation notes.
- Network security testing results (`nmap` from workstation only, targeting server).
- Access control verification (SSH, sudoers, MAC status).
- Service audit: list running services with justification.
- Remaining risks and mitigation plan.

## Commands and evidence (examples)
```bash
# On server
sudo lynis audit system --quiet --logfile /var/log/lynis.log
grep -E "hardening_index|warning|suggestion" /var/log/lynis.log

# From workstation
nmap -sV -Pn 192.168.56.10
ssh user@server "systemctl list-units --type=service --state=running | head -n 30"
ssh user@server "sudo apparmor_status || sudo getenforce"
```

## Reporting structure
- Summary of findings (top risks, scores, exposed ports).
- Evidence snippets (links to logs in `data/audit/`).
- Remediations applied and their effect on Lynis score.
- Remaining risk assessment with rationale (accepted/mitigated/deferred).
- Final reflection connecting security, performance, and usability trade-offs.

## Demonstration prep
- 8-minute video script: summary → architecture → live CLI → critical analysis.
- Show `security-baseline.sh` and monitoring commands live.
- Ensure captions/voice clearly explain command purpose and output meaning.

---
[← Week 6](week6.md) | [Home](index.md)
