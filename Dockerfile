FROM debian:bookworm-slim AS base
RUN apt-get update \
 && apt-get install -y --no-install-recommends curl ca-certificates \
 && rm -rf /var/lib/apt/lists/*
WORKDIR /opt/demo-ci-app
COPY app/ app/

FROM base AS test
COPY tests/ tests/
RUN bash tests/test_healthcheck.sh

FROM base AS final
RUN useradd --no-create-home --shell /usr/sbin/nologin --uid 1001 appuser
USER appuser
ENTRYPOINT ["bash", "app/healthcheck.sh"]
CMD ["80"]
