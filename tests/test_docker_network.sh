#!/usr/bin/env bash
set -u
NET=demo-test-net

cleanup() {
  docker rm -f web-test >/dev/null 2>&1
  docker network rm "$NET" >/dev/null 2>&1
}
trap cleanup EXIT

docker network create "$NET" >/dev/null
docker run -d --name web-test --network "$NET" nginx:1.27-alpine >/dev/null
sleep 2

if docker run --rm --network "$NET" demo-ci-app:1.0 100 http://web-test >/dev/null; then
  echo "PASS: web reachable by name"
else
  echo "FAIL: web should be reachable"; exit 1
fi

docker stop web-test >/dev/null
if docker run --rm --network "$NET" demo-ci-app:1.0 100 http://web-test >/dev/null; then
  echo "FAIL: stopped web should fail"; exit 1
else
  echo "PASS: stopped web fails as expected"
fi
