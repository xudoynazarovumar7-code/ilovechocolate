#!/bin/sh
# Runs every time the container starts.
set -e
python manage.py migrate --noinput
python manage.py seed_demo
exec gunicorn config.wsgi:application --bind 0.0.0.0:7860 --workers 2
