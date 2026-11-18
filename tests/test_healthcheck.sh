#!/usr/bin/env bash
set -u

if bash app/healthcheck.sh 100 >/dev/null; then
  echo "PASS: threshold 100 succeeds"
else
  echo "FAIL: threshold 100 should succeed"; exit 1
fi

if bash app/healthcheck.sh 0 >/dev/null; then
  echo "FAIL: threshold 0 should fail"; exit 1
else
  echo "PASS: threshold 0 fails as expected"
fi

if bash app/healthcheck.sh -h | grep -q "Usage"; then
  echo "PASS: -h prints usage"
else
  echo "FAIL: -h should print usage"; exit 1
fi

if bash app/healthcheck.sh 100 http://localhost:9 >/dev/null; then
  echo "FAIL: unreachable URL should fail"; exit 1
else
  echo "PASS: unreachable URL fails as expected"
fi
