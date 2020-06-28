#!/bin/bash

if [[ -e "./requirements.txt" ]]; then
    $(command -v pip) install -r ./requirements.txt
fi

case "$1" in
  webserver)
    airflow initdb
    airflow scheduler &
    exec airflow webserver
    ;;
  scheduler|worker)
    sleep 20
    exec airflow "$@"
    ;;
  *)
    exec "$@"
    ;;
esac