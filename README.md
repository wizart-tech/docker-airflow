# Dockerized Apache Airflow with LocalExecutor and Postgres Backend.

### Prerequisites

- Install [Docker](https://www.docker.com/)
- Install [Docker Compose](https://docs.docker.com/compose/install/)
- Follow Apache Airflow Principles and How-To Guides in [Docs](https://airflow.apache.org/docs/stable/)

### Usage

For the first run, build containers using predefined **make** shortcuts:
```bash
make up
```
to list all available make shortcuts, type
```bash
make help
```

### Create Superuser

```bash
docker-compose run --rm webserver bash  # or make shell-root
airflow create_user [-h] [-r ROLE] [-u USERNAME] [-e EMAIL] [-f FIRSTNAME] \
                    [-l LASTNAME] [-p PASSWORD] [--use_random_password]
```

## Executing airflow commands

If you want to run any of airflow commands, you can do the following:  `docker-compose run --rm webserver [some command]`

- `docker-compose run --rm webserver airflow list_dags` - List dags
- `docker-compose run --rm webserver airflow test [DAG_ID] [TASK_ID] [EXECUTION_DATE]` - Test specific task
- `docker-compose run --rm webserver python /usr/local/airflow/dags/[PYTHON-FILE].py` - Test custom python script

## TODO
- Solve Fernet Key Issue
- Celery Executor
- User-defined backend support
