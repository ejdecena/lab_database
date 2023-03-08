# Database Laboratory.


This repository is intended to be a platform or academic laboratory for database design and implementation. This laboratory is based on Docker technology to lift Postgres 15 and PgAdmin 4 services in a Linux environment, mainly.


## To install Docker:
```bash
$ make install
```

## To run the laboratory:
```bash
$ make run
```

![Login Pgadmin parameters](/images/login.png "Login Pgadmin parameters").

GO TO http://{PGADMIN_ADDRESS}:{PGADMIN_PORT}
Username: {PGADMIN_DEFAULT_EMAIL} in ```.env``` file.
Password: {PGADMIN_DEFAULT_PASSWORD} in ```.env``` file.

## To access the Postgres container:
```bash
$ make psql
```

## To look the logs of the laboratory:
```bash
$ make logs
```

## To stop the laboratory:
```bash
$ make stop
```

## To restart the laboratory:
```bash
$ make restart
```

## To reset the databases of laboratory:
```bash
$ make reset
```
## To connect Pgadmin to Postgres:
```bash
$ make ip
```

After executing the above command, copy the IP address and copy it into the connection parameters in Pgadmin. Other data for the connection are:

* Host name / address: {IPAddress}
* Port: 5432
* Database: {POSTGRES_DB} in ```.env``` file.
* Username: {POSTGRES_USER} in ```.env``` file.
* Pass: {POSTGRES_PASSWORD} in ```.env``` file.

![Connection parameters](/images/database_conexion.png "To connect Pgadmin to Postgres").