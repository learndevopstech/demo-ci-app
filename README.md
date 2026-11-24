# demo-ci-app

A small CI/CD practice project: a Bash health-check script with automated tests, built and packaged by a Jenkins pipeline and a GitHub Actions workflow.

## What it does
- `app/healthcheck.sh` checks disk usage against a threshold, and can check that URLs respond.
- `tests/test_healthcheck.sh` tests success, failure, `-h` help and unreachable-URL cases.

## Run it locally
    bash tests/test_healthcheck.sh
    bash app/healthcheck.sh 80
    bash app/healthcheck.sh -h

## CI/CD
- `Jenkinsfile`: Lint, Test, Health check (with a THRESHOLD build parameter) and Package stages, with the package saved as a build artifact.
- `.github/workflows/ci.yml`: the same stages on GitHub Actions.

## Environment
Ubuntu Server in VirtualBox, accessed over SSH, with Jenkins installed on the VM.

## What I practised
Git branching, Pull Requests, merge conflicts, revert and reset, Jenkins pipelines (Poll SCM, Multibranch), and diagnosing failed builds from logs.
