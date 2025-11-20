---
title: Home
---

# Operating Systems Coursework Journal

GitHub Pages journal for CMPN202 Operating Systems coursework (Weeks 1–7). Replace the placeholders with your own evidence, commands, graphs, and reflections. Keep command prompts visible (`user@host`) in screenshots and cite sources using IEEE style.

## Table of contents
- [Week 1 — System Planning](week1.md)
- [Week 2 — Security Planning & Test Methodology](week2.md)
- [Week 3 — Application Selection](week3.md)
- [Week 4 — Initial Configuration & Security](week4.md)
- [Week 5 — Advanced Security & Monitoring](week5.md)
- [Week 6 — Performance Evaluation](week6.md)
- [Week 7 — Security Audit & Evaluation](week7.md)

## Project overview
- Server: headless Linux server managed **only via SSH**.
- Workstation: SSH client + monitoring tools.
- Journal: public GitHub Pages with weekly updates, diagrams, screenshots, commands, and reflection.
- Demonstration: ≤ 8 minute video with clear audio narration, live commands, and explanations.

## Evidence checklist
- Architecture diagrams (update weekly as topology changes).
- CLI evidence with explanations (before/after configs, firewall rules, SSH setup).
- Quantitative data: performance tables, graphs, Lynis scores, optimisation results.
- Trade-off analysis: security vs performance, configuration choices, mitigation effectiveness.
- Scripts: `security-baseline.sh` (server) and `monitor-server.sh` (workstation) with comments and usage.

## How to edit locally
```bash
npm install --global serve  # optional local preview
serve docs                  # visit http://localhost:3000
```
(GitHub Pages will build automatically from the `/docs` folder when pushed to GitHub.)

---

> Tip: Keep weekly commits small and descriptive (e.g., `week3-add-app-matrix`, `week5-enable-fail2ban`).***
