FROM debian:bookworm-slim

RUN apt-get update \
 && apt-get install -y --no-install-recommends curl ca-certificates \
 && rm -rf /var/lib/apt/lists/*

WORKDIR /opt/demo-ci-app
COPY app/ app/
COPY tests/ tests/

ENTRYPOINT ["bash", "app/healthcheck.sh"]
CMD ["80"]
