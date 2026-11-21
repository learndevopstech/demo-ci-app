#!/usr/bin/env bash
set -euo pipefail

usage() {
  echo "Usage: $0 [threshold] [url ...]"
  echo "  threshold  disk usage percent that fails the check (default 80)"
  echo "  url        optional URLs that must respond"
  echo "  -h         show this help"
}

if [ "${1:-}" = "-h" ] || [ "${1:-}" = "--help" ]; then
  usage
  exit 0
fi

THRESHOLD="${1:-80}"
USAGE=$(df / --output=pcent | tail -1 | tr -dc '0-9')
echo "Disk usage on /: ${USAGE}% (threshold ${THRESHOLD}%)"
echo "Checked at $(date '+%Y-%m-%d %H:%M:%S')"
if [ "$USAGE" -ge "$THRESHOLD" ]; then
  echo "FAIL: disk usage above threshold"
  exit 1
fi

for URL in "${@:2}"; do
  if curl -sf -o /dev/null --max-time 5 "$URL"; then
    echo "URL OK: $URL"
  else
    echo "FAIL: cannot reach $URL"
    exit 1
  fi
done
echo "OK"
# added by teammate
# added by mari for jenkins run
