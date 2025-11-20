---
title: Week 6 — Performance Evaluation & Analysis
---

## Objectives
- Run performance tests for each selected application.
- Capture metrics (CPU, RAM, disk, network, latency) under baseline, load, and optimisation scenarios.
- Produce tables and graphs; document bottlenecks and optimisations.

## Deliverables
- Performance data table (CSV in `data/`).
- Visualisations (add PNG/SVG charts to `docs/assets/` and embed here).
- Testing evidence (command outputs, screenshots).
- Network performance analysis (latency/throughput).
- Optimisation attempts with quantitative before/after.

## Testing flow (example)
1. Baseline idle capture: `./scripts/monitor-server.sh user@server data/baseline.csv 10`.
2. CPU test: `ssh user@server "stress-ng --cpu 4 --timeout 120"` while monitoring.
3. Disk test: `ssh user@server "fio --name=randrw --rw=randrw --bs=4k --size=1G --iodepth=16 --numjobs=2 --time_based --runtime=120"`.
4. Network: `iperf3 -s` (server) / `iperf3 -c <server> -t 60` (workstation).
5. Service test: load-test `nginx` via `wrk`/`ab`/`curl -w`.
6. Optimisations: tune `sysctl` (e.g., `vm.swappiness`), web server worker counts, CPU governor, disk scheduler; repeat measurements.

## Data capture
- Append runs to `data/performance-template.csv` (or create new files per scenario).
- Include columns: timestamp, test name, metric, value, units, notes.
- Keep raw command outputs in `data/logs/` for traceability.

## Reflection
- Which resource was the bottleneck for each workload?
- Which optimisation gave measurable improvement? Provide % change with raw numbers.
- Any security controls impacting performance? Note trade-offs clearly.

---
[← Week 5](week5.md) | [Home](index.md) | [Week 7 →](week7.md)
