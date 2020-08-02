# Dockerized Apache Airflow with LocalExecutor and Postgres Backend.

### Prerequisites

- Install [Docker](https://www.docker.com/)
- Install [Docker Compose](https://docs.docker.com/compose/install/)
- Follow Apache Airflow Principles and How-To Guides in [Docs](https://airflow.apache.org/docs/stable/)

### Security
In order to secure Airflow Connections and Variables, generate `fernet_key`. It can be done using Python:

```python
>> from cryptography.fernet import Fernet
>> Fernet.generate_key().decode()
'=69ksvvORDpeoBrz2N38El18kOxJFPU2peg22So66k7U=' # here is your fernet key
```
Store the generated key in **env_file** called `airflow.env` like It shown below:
```bash
AIRFLOW__CORE__FERNET_KEY=69ksvvORDpeoBrz2N38El18kOxJFPU2peg22So66k7U=
```
**Note:** You can use `airflow.env` to define any container-level [configurations](https://airflow.readthedocs.io/en/stable/howto/set-config.html) for Airflow. 

Additional information about securing connections can be found [here](https://airflow.readthedocs.io/en/stable/howto/secure-connections.html).

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
- Celery Executor

