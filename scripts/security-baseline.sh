#!/usr/bin/env bash
# Security baseline verification script for CMPN202 server (run on the server via SSH).
# Exits on errors and treats unset variables as errors to avoid silent failures.
set -euo pipefail

# Ensure the script is executed with root privileges because many checks require elevated access.
if [[ "${EUID:-$(id -u)}" -ne 0 ]]; then
  echo "Please run as root (sudo ./security-baseline.sh)" >&2
  exit 1
fi

# Print a section header for readability.
section() {
  # Capture the label passed to the function.
  local label="$1"
  # Print a blank line before each section.
  echo
  # Print the formatted section label.
  echo "=== ${label} ==="
}

# Safely run a command if it exists, otherwise note the missing tool.
run_if_exists() {
  # Capture the command to execute.
  local cmd="$1"
  # Check whether the command is available in PATH.
  if command -v "${cmd%% *}" >/dev/null 2>&1; then
    # Execute the command if present.
    eval "$cmd"
  else
    # Warn if the command is missing to help with remediation.
    echo "Missing command: ${cmd%% *}"
  fi
}

# Start SSH configuration checks.
section "SSH configuration"
# Show current SSH daemon status.
run_if_exists "systemctl status sshd --no-pager --lines=3"
# Show whether root login is disabled.
grep -iE '^PermitRootLogin' /etc/ssh/sshd_config 2>/dev/null || echo "PermitRootLogin not set"
# Show whether password authentication is disabled.
grep -iE '^PasswordAuthentication' /etc/ssh/sshd_config 2>/dev/null || echo "PasswordAuthentication not set"
# Show whether AllowUsers is restricting access.
grep -iE '^AllowUsers' /etc/ssh/sshd_config 2>/dev/null || echo "AllowUsers not set"
# Validate authorized_keys exists for the admin user.
find /home -maxdepth 2 -name authorized_keys -print
# Show active SSH port and listen addresses.
run_if_exists "ss -tlnp | grep sshd"

# Firewall overview using ufw, firewall-cmd, or iptables/nftables as available.
section "Firewall rules"
# Display ufw status if ufw is installed.
run_if_exists "ufw status verbose"
# Display firewalld info if firewalld is installed.
run_if_exists "firewall-cmd --state"
run_if_exists "firewall-cmd --list-all"
# Show nftables ruleset if present.
run_if_exists "nft list ruleset"
# Fallback to iptables listing if nftables is unavailable.
run_if_exists "iptables -S"

# Access control (SELinux/AppArmor) status.
section "Mandatory access control"
# Show SELinux enforcement state if SELinux tools exist.
run_if_exists "getenforce"
run_if_exists "sestatus"
# Show AppArmor profiles if AppArmor is present.
run_if_exists "apparmor_status"

# Automatic security updates status.
section "Automatic updates"
# On Debian/Ubuntu, check unattended-upgrades package and config.
if command -v unattended-upgrades >/dev/null 2>&1; then
  # Show unattended-upgrades timer status.
  run_if_exists "systemctl status unattended-upgrades --no-pager --lines=2"
  # Show apt periodic settings.
  run_if_exists "grep -E \"(Unattended-Upgrade|Update-Package-Lists|Download-Upgradeable-Packages)\" /etc/apt/apt.conf.d/20auto-upgrades"
else
  # For RPM-based systems, show dnf-automatic if present.
  run_if_exists "systemctl status dnf-automatic.timer --no-pager --lines=2"
fi

# fail2ban status and recent bans.
section "fail2ban"
# Show fail2ban service state.
run_if_exists "systemctl status fail2ban --no-pager --lines=2"
# List configured jails.
run_if_exists "fail2ban-client status"
# Show SSH jail summary if available.
run_if_exists "fail2ban-client status sshd"

# User and sudo policy checks.
section "Users and sudoers"
# List admin-like groups to confirm only intended users have sudo.
getent group sudo || true
getent group wheel || true
# Show sudoers drop-in files for review.
ls -l /etc/sudoers.d || true
# Display sudoers file syntax check to catch errors.
run_if_exists "visudo -c"

# Service inventory to justify running daemons.
section "Running services (top 15)"
# Show the top 15 running services for audit purposes.
systemctl list-units --type=service --state=running | head -n 20

# Network listening sockets (should align with firewall policy).
section "Listening ports"
# List listening TCP/UDP sockets with owning processes.
run_if_exists "ss -tulpen"

# Kernel and system hardening spot-checks.
section "Kernel hardening spot-checks"
# Show SSH banners if set.
run_if_exists "grep -iE \"^(Banner|DebianBanner)\" /etc/ssh/sshd_config"
# Show swap tendency; lower values reduce swapping.
run_if_exists "sysctl vm.swappiness"
# Show IP forwarding state; should be off unless required.
run_if_exists "sysctl net.ipv4.ip_forward"

# Summarise completion.
section "Summary"
# Print success message when all sections have run.
echo "Baseline checks completed. Review outputs above for gaps."
