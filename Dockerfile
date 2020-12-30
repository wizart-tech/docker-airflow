FROM python:3.8-slim-buster
LABEL maintainer="Artur Kuchynski <arturkuchynski@gmail.com>" \
    description="Dockerized Apache Airflow"

ENV DEBIAN_FRONTEND noninteractive
ENV TERM linux
ENV LANGUAGE=C.UTF-8 LANG=C.UTF-8 LC_ALL=C.UTF-8 \
    LC_CTYPE=C.UTF-8 LC_MESSAGES=C.UTF-8
ENV GUNICORN_CMD_ARGS --log-level WARNING

ARG AIRFLOW_HOME=/usr/local/airflow
ENV AIRFLOW_HOME=${AIRFLOW_HOME}

ARG AIRFLOW_VERSION=2.0.0
ARG AIRFLOW_DATA_PATH=/usr/local/airflow_data
ARG AIRFLOW_EXTRA_DEPS=""
ARG SYSTEM_EXTRA_DEPS=""

RUN apt-get update -yqq \
    && apt-get upgrade -yqq \
    && apt-get install -yqq --no-install-recommends \
        build-essential \
        default-libmysqlclient-dev \
        apt-utils \
        curl \
        rsync \
        netcat \
        locales \
        git \
        wget \
        libsm6 \
        libxrender1 \
        libpq-dev \
        libsasl2-dev \
        libssl-dev \
        libffi-dev \
        libkrb5-dev \
        ${SYSTEM_EXTRA_DEPS} \
    && useradd --shell /bin/bash --create-home --home ${AIRFLOW_HOME} airflow \
    && pip install -U pip setuptools wheel \
    && pip install ndg-httpsclient pytz pyOpenSSL pyasn1 typing-extensions ipython psycopg2-binary \
    && pip install apache-airflow[async,aws,crypto,mysql,postgres,password,ssh,celery${AIRFLOW_EXTRA_DEPS:+,}${AIRFLOW_EXTRA_DEPS}]==${AIRFLOW_VERSION} \
    && apt-get autoremove -yqq --purge \
    && apt-get clean \
    && rm -rf \
        /var/lib/apt/lists/* \
        /var/tmp/* \
        /tmp/*

COPY requirements.txt ${AIRFLOW_HOME}/requirements.txt
COPY entrypoint.sh ${AIRFLOW_HOME}/entrypoint.sh
COPY airflow.cfg ${AIRFLOW_HOME}/airflow.cfg

RUN pip install --no-cache-dir -r ${AIRFLOW_HOME}/requirements.txt
RUN mkdir -p ${AIRFLOW_HOME}/logs && mkdir -p ${AIRFLOW_HOME}/dags && mkdir -p ${AIRFLOW_DATA_PATH}
RUN chown -R airflow: ${AIRFLOW_HOME} && chown -R airflow: ${AIRFLOW_DATA_PATH}
RUN chmod +x ${AIRFLOW_HOME}/entrypoint.sh

WORKDIR ${AIRFLOW_HOME}

EXPOSE 8080 5555 8793

ENTRYPOINT ["./entrypoint.sh"]
CMD ["webserver"]