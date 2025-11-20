# CMPN202 Operating Systems Coursework

GitHub-ready repository for the Operating Systems coursework journal and demo described in `Assessment Brief CMPN202 Operating Systems Coursework_v010.pdf`. It includes GitHub Pages content for all seven weeks plus the required security and monitoring scripts.

## Repository structure
- `docs/`: GitHub Pages site (home plus Week 1–7 pages, nav links, and configuration).
- `scripts/security-baseline.sh`: Server-side verification script for Phases 4–5 security controls.
- `scripts/monitor-server.sh`: Workstation-side remote monitoring script that collects metrics from the server over SSH.
- `data/`: Placeholders for performance measurements and audit evidence.
- `Assessment Brief CMPN202 Operating Systems Coursework_v010.pdf`: Original brief for reference.

## Quick start (GitHub Pages)
1. Push this repo to GitHub.
2. In repository settings → Pages, choose source `main` branch, folder `/docs`.
3. Visit the published URL to view the journal (home page plus weekly pages).

## Using the scripts
- `scripts/security-baseline.sh`: Run **on the server** (via SSH) to verify key security controls. Example:
  ```bash
  chmod +x scripts/security-baseline.sh
  ./scripts/security-baseline.sh | tee security-baseline-report.txt
  ```
- `scripts/monitor-server.sh`: Run **on the workstation** to pull metrics over SSH and append to CSV in `data/`.
  ```bash
  chmod +x scripts/monitor-server.sh
  ./scripts/monitor-server.sh user@server-ip data/perf-sample.csv 30
  ```

## Customise for your work
- Replace placeholder text (e.g., `YOUR_STUDENT_ID`, dates, IPs, distro choices) with your real values.
- Add your own screenshots to `docs/assets/` and embed them in the weekly pages.
- Add real performance data to `data/performance-template.csv` or export new CSVs during testing.
- Update the scripts if your distribution uses different service names or tools.

## Submission checklist (from the brief)
- GitHub Pages site with home page + seven weekly sections.
- `StudentID_GitHub_URL.txt` pointing to your Pages site.
- `StudentID_OSCoursework_Demonstration.mp4` (≤ 8 minutes).
- Evidence of security controls, monitoring, performance testing, optimisation, and critical reflection per week.

Refer to the PDF brief for full marking criteria and deadlines.***
