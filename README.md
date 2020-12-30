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
Specify the `secret_key` setting under the `[webserver]` config. 
Change this value to a new, per-environment, randomly generated string.

For example using this command `openssl rand -hex 30`

Store the generated keys in **env_file** and name It `airflow.env`, just like It shown below:
```bash
AIRFLOW__CORE__FERNET_KEY=69ksvvORDpeoBrz2N38El18kOxJFPU2peg22So66k7U=
AIRFLOW__WEBSERVER__SECRET_KEY=1ca384d704f852756df25a7560c3338cb3a65cccf2fd734440f94deb5d32
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

### Create Users

```bash
docker-compose run --rm webserver bash  # or make shell-root
airflow users create \
    --role Admin \
    --username admin \
    --firstname FIRST_NAME \
    --lastname LAST_NAME \
    --email EMAIL@example.org
```

## Executing airflow commands

If you want to run any of airflow commands, you can do the following:  `docker-compose run --rm webserver [some command]`

- `docker-compose run --rm webserver airflow list_dags` - List dags
- `docker-compose run --rm webserver airflow test [DAG_ID] [TASK_ID] [EXECUTION_DATE]` - Test specific task
- `docker-compose run --rm webserver python /usr/local/airflow/dags/[PYTHON-FILE].py` - Test custom python script

## TODO
- Celery Executor

