.PHONY: help ps build up down restart shell shell-root shell-ipython shell-db clean-cache
SHELL=/bin/bash

help:
	@echo 'make ps               list containers.'
	@echo 'make build            build an image from a Dockerfile.'
	@echo 'make up               build, (re)create, start, and attach to containers for a service.'
	@echo 'make down             stop and remove containers, networks, volumes, and images created by up.'
	@echo 'make restart          restart all stopped and running services.'
	@echo 'make shell            connect to webserver container in new bash shell.'
	@echo 'make shell-root       connect to webserver container in new bash shell as root.'
	@echo 'make shell-ipython    connect to webserver container in new bash shell.'
	@echo 'make shell-db         shell into psql inside postgres container.'
	@echo 'make clean-cache 	 remove python cache files from tree.'


ps: docker-ps
build:docker-build
up: docker-up
down: docker-down
restart: docker-down docker-up

docker-ps:
	docker-compose ps

docker-build:
	docker-compose build

docker-up:
	docker-compose up -d --build

docker-down:
	docker-compose down

shell:
	docker-compose exec -u airflow webserver bash

shell-root:
	docker-compose exec -u root webserver bash

shell-ipython:
	docker-compose exec -u airflow webserver ipython

shell-db:
	docker-compose exec postgres psql -w --username "airflow" --dbname "airflow"

clean-cache:
	find . -name '*.py[cod]' -exec rm --force {} +
