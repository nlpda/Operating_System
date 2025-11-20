#!/usr/bin/env bash
# Remote monitoring helper run from the workstation; collects server metrics over SSH into CSV.
# Exits on errors and treats unset variables as errors to avoid silent failures.
set -euo pipefail

# Show usage if required arguments are missing.
if [[ $# -lt 2 ]]; then
  # Print usage instructions.
  echo "Usage: $0 <user@server> <output_csv> [interval_seconds]" >&2
  # Exit with error status due to missing arguments.
  exit 1
fi

# Capture the SSH target (user@host or user@ip).
TARGET="$1"
# Capture the path to the output CSV file.
OUTPUT="$2"
# Capture the sampling interval in seconds (default 30s).
INTERVAL="${3:-30}"

# Create the output directory if it does not already exist.
mkdir -p "$(dirname "$OUTPUT")"

# If the CSV file does not exist yet, write the header row.
if [[ ! -f "$OUTPUT" ]]; then
  # Write CSV column headers.
  echo "timestamp,load1,cpu_util_percent,mem_used_mb,mem_avail_mb,swap_used_mb,root_used_percent,iface,rx_bytes,tx_bytes" > "$OUTPUT"
fi

# Inform the user that sampling has started.
echo "Starting remote sampling from $TARGET every ${INTERVAL}s; writing to $OUTPUT"
# Suggest how to stop sampling.
echo "Press Ctrl+C to stop."

# Begin an infinite loop until the user stops the script.
while true; do
  # Build the remote command that gathers metrics on the server.
  read -r -d '' REMOTE_CMD <<'EOF'
set -euo pipefail
# Capture current timestamp in ISO format.
ts="$(date -Iseconds)"
# Extract 1-minute load average.
load1="$(cut -d' ' -f1 /proc/loadavg)"
# Collect CPU idle percentage from vmstat; default to 0 if vmstat is missing.
if command -v vmstat >/dev/null 2>&1; then
  # Take two samples and read the last line for stable data.
  cpu_idle="$(vmstat 1 2 | tail -n 1 | awk '{print $15}')"
else
  # Fallback idle value when vmstat is unavailable.
  cpu_idle=0
fi
# Compute CPU utilisation as 100 - idle.
cpu_util="$((100 - cpu_idle))"
# Read memory totals (kB) from /proc/meminfo.
mem_total_kb="$(awk '/MemTotal/ {print $2}' /proc/meminfo)"
mem_avail_kb="$(awk '/MemAvailable/ {print $2}' /proc/meminfo)"
# Convert available memory to MB.
mem_avail_mb="$((mem_avail_kb / 1024))"
# Compute used memory in MB.
mem_used_mb="$(((mem_total_kb - mem_avail_kb) / 1024))"
# Collect swap usage (kB) from /proc/meminfo.
swap_total_kb="$(awk '/SwapTotal/ {print $2}' /proc/meminfo)"
swap_free_kb="$(awk '/SwapFree/ {print $2}' /proc/meminfo)"
# Compute used swap in MB.
swap_used_mb="$(((swap_total_kb - swap_free_kb) / 1024))"
# Determine root filesystem usage percentage.
root_used_percent="$(df -P / | awk 'NR==2 {gsub(\"%\",\"\",$5); print $5}')"
# Determine default network interface from routing table.
iface="$(ip route show default 2>/dev/null | awk 'NR==1 {print $5}')"
# If the interface is empty, set it to unknown to avoid empty CSV fields.
if [[ -z "$iface" ]]; then iface="unknown"; fi
# Read received bytes from the interface (0 if path missing).
rx_bytes="$(cat /sys/class/net/"$iface"/statistics/rx_bytes 2>/dev/null || echo 0)"
# Read transmitted bytes from the interface (0 if path missing).
tx_bytes="$(cat /sys/class/net/"$iface"/statistics/tx_bytes 2>/dev/null || echo 0)"
# Emit a single CSV line with all metrics.
echo "$ts,$load1,$cpu_util,$mem_used_mb,$mem_avail_mb,$swap_used_mb,$root_used_percent,$iface,$rx_bytes,$tx_bytes"
EOF
  # Execute the remote command over SSH and capture its output.
  sample_line="$(ssh -o BatchMode=yes "$TARGET" "$REMOTE_CMD")"
  # Append the captured metrics to the CSV file.
  echo "$sample_line" >> "$OUTPUT"
  # Sleep for the requested interval before the next sample.
  sleep "$INTERVAL"
done
