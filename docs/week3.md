---
title: Week 3 — Application Selection for Performance Testing
---

## Objectives
- Select applications that stress different resources.
- Document install commands (SSH-only) and expected resource profiles.
- Define monitoring strategy per application.

## Deliverables
- Application Selection Matrix (CPU, RAM, I/O, Network, Server).
- Installation commands with exact packages and flags.
- Expected resource profiles and monitoring plan.

## Application selection matrix (example)
| Type | App | Why this app? | Install (SSH) | Expected profile |
| --- | --- | --- | --- | --- |
| CPU | `stress-ng` | Controlled CPU load | `sudo apt install -y stress-ng` | 100% of selected cores |
| RAM | `stress-ng --vm` | Heap pressure | Already installed | High RSS until limit |
| I/O | `fio` | Flexible disk tests | `sudo apt install -y fio` | High disk util, queue depth |
| Network | `iperf3` | Throughput/latency | `sudo apt install -y iperf3` | Saturates NIC, tracks jitter |
| Server | `nginx` | Real service workload | `sudo apt install -y nginx` | Moderate CPU, network |

Update with your chosen tools and distro-specific commands.

## Monitoring strategy
- CPU/RAM: `top`, `pidstat`, `vmstat 5`, `sar -u`, `/proc/meminfo`.
- Disk: `iostat -xz 5`, `fio` built-in reports.
- Network: `iperf3 -s`/`-c`, `ss -tna`, `nstat`.
- Latency/service: `curl -w "%{time_total}"`, `ab`/`wrk` (if available).
- Capture outputs to CSV/JSON and visualise in Week 6.

## Reflection
- Justify each app against marking criteria (breadth of workloads).
- Risks: missing packages, kernel modules, required ports.
- Prep firewall exceptions for chosen services (document in Week 4).

---
[← Week 2](week2.md) | [Home](index.md) | [Week 4 →](week4.md)
