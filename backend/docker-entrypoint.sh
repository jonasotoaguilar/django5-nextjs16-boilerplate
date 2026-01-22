#!/bin/sh

# Wrapper to run commands either via uv or directly
run_cmd() {
  if command -v uv >/dev/null 2>&1; then
    uv run "$@"
  else
    "$@"
  fi
}

apply_migrations() {
  echo "Applying database migrations..."
  run_cmd python manage.py migrate
}

apply_fixtures() {
  echo "Applying Django fixtures..."
  for fixture in fixtures/dev/*.json; do
    if [ -f "$fixture" ]; then
      echo "Loading $fixture"
      run_cmd python manage.py loaddata "$fixture"
    fi
  done
}

start_dev_server() {
  echo "Starting the development server..."
  run_cmd python manage.py runserver 0.0.0.0:"${DJANGO_PORT:-8080}"
}

start_prod_server() {
  echo "Starting the Gunicorn server..."
  run_cmd gunicorn --bind 0.0.0.0:8000 --workers 4 api.wsgi:application
}

case "$1" in
  dev)
    apply_migrations
    apply_fixtures
    start_dev_server
    ;;
  prod)
    apply_migrations
    start_prod_server
    ;;
  *)
    echo "Usage: $0 {dev|prod}"
    exit 1
    ;;
esac
