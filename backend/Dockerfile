# syntax=docker/dockerfile:1
FROM python:3.14-slim-bookworm AS build

ENV PYTHONUNBUFFERED=1
ENV PYTHONDONTWRITEBYTECODE=1
ENV UV_PROJECT_ENVIRONMENT=/.venv

WORKDIR /app

RUN pip install --no-cache-dir uv==0.5.21

COPY pyproject.toml uv.lock ./
RUN uv sync --frozen --no-dev --no-install-project

COPY . .
RUN uv sync --frozen --no-dev

# Development stage
FROM python:3.14-slim-bookworm AS dev

ENV PYTHONUNBUFFERED=1
ENV PYTHONDONTWRITEBYTECODE=1
ENV UV_PROJECT_ENVIRONMENT=/.venv

WORKDIR /app

RUN pip install --no-cache-dir uv==0.5.21

# Create non-root user with home directory
RUN addgroup --system django && \
    adduser --system --ingroup django --home /home/django django

COPY pyproject.toml uv.lock ./
RUN uv sync --frozen --no-install-project

# Copy entrypoint script and set permissions
# Copy entrypoint script and set permissions
COPY --chown=django:django docker-entrypoint.sh ./
RUN chmod +x docker-entrypoint.sh && \
    chown -R django:django /app && \
    mkdir -p /home/django/.cache/uv && \
    chown -R django:django /home/django/.cache

ENV PATH="/.venv/bin:$PATH"
ENV UV_CACHE_DIR="/home/django/.cache/uv"

USER django

EXPOSE 8000

ENTRYPOINT ["./docker-entrypoint.sh"]

# Production stage
FROM python:3.14-slim-bookworm AS prod

WORKDIR /app

# Create non-root user with home directory
RUN addgroup --system django && \
    adduser --system --ingroup django --home /home/django django

COPY --from=build /.venv /.venv
COPY . .

# Copy entrypoint script and set permissions
# Copy entrypoint script and set permissions
COPY --chown=django:django docker-entrypoint.sh ./
RUN chmod +x docker-entrypoint.sh && \
    chown -R django:django /app && \
    mkdir -p /home/django/.cache/uv && \
    chown -R django:django /home/django/.cache

ENV PATH="/.venv/bin:$PATH"
ENV UV_CACHE_DIR="/home/django/.cache/uv"

USER django

EXPOSE 8000

ENTRYPOINT ["./docker-entrypoint.sh"]
