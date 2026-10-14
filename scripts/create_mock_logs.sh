#!/usr/bin/env bash
# Re-create the mock log file. This script does not create users or change permissions.
set -euo pipefail
SCRIPT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
LOG_DIR="$SCRIPT_DIR/../logs"
mkdir -p "$LOG_DIR"
cat > "$LOG_DIR/sys_events.log" <<'EOF'
2026-10-14 08:00:01 INFO user01 login successful from 192.0.2.10
2026-10-14 08:01:12 INFO root started scheduled maintenance
2026-10-14 08:02:25 WARNING user01 entered an invalid password
2026-10-14 08:03:41 ERROR user01 failed authentication
2026-10-14 08:04:03 INFO service ssh started
2026-10-14 08:05:17 WARNING disk usage reached 75 percent
2026-10-14 08:06:22 INFO root checked system status
2026-10-14 08:07:30 ERROR service backup failed
2026-10-14 08:08:45 INFO user01 opened the dashboard
2026-10-14 08:09:51 WARNING multiple login attempts detected
2026-10-14 08:10:08 INFO cron job completed
2026-10-14 08:11:16 ERROR root could not access a test resource
2026-10-14 08:12:24 INFO user01 signed out
2026-10-14 08:13:39 WARNING ssh connection timed out
2026-10-14 08:14:42 INFO firewall rules loaded
2026-10-14 08:15:56 ERROR service web failed to start
2026-10-14 08:16:11 INFO root reviewed system logs
2026-10-14 08:17:29 WARNING temporary directory nearing capacity
2026-10-14 08:18:33 INFO user01 login successful from 192.0.2.11
2026-10-14 08:19:47 ERROR user01 permission check failed
EOF
grep "ERROR" "$LOG_DIR/sys_events.log" > "$LOG_DIR/error_report.txt"
echo "Created mock log: $LOG_DIR/sys_events.log"
echo "Line count:"
wc -l "$LOG_DIR/sys_events.log"
echo "Error report: $LOG_DIR/error_report.txt"
