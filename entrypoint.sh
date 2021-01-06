#!/bin/bash


case "$1" in
  webserver)
    airflow db init
    airflow db upgrade
    airflow scheduler &
    exec airflow webserver
    ;;
  scheduler)
    sleep 20
    exec airflow "$@"
    ;;
  worker|flower)
    sleep 20
    exec airflow celery "$@"
    ;;
  *)
    exec "$@"
    ;;
esac