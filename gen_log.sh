#!/bin/bash

for i in $(seq 1 500); do
  case $((RANDOM % 3)) in
    0) LEVEL=INFO ;;
    1) LEVEL=WARN ;;
    2) LEVEL=ERROR ;;
  esac
  echo "2026-11-15 $(printf '%02d' $((RANDOM % 24))):$(printf '%02d' $((RANDOM % 60))):00 $LEVEL message $i" >> ~/demo-ci-app/logs/app.log
done
