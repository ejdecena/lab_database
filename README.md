# Database Laboratory.


This repository is intended to be a platform or academic laboratory for database design and implementation. This laboratory is based on Docker technology to lift Postgres 15 and PgAdmin 4 services in a Linux environment, mainly.


## To install Docker:
```bash
$ ./install-docker.sh
```

## To run the laboratory:
```bash
$ make run
```

From a web browser, access the address http://127.0.0.1:5050, and enter as username *user@gmail.com*, and as password *admin*.

![Login Pgadmin parameters](/images/login.png "Login Pgadmin parameters").

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
$ docker inspect postgres_db
```

After executing the above command, copy the IP address of the given container into the *IPAddress* field and copy it into the connection parameters in Pgadmin. Other data for the connection are

* Host name / address: *IPAddress*
* Port: 5432
* Database: postgres
* Username: user
* Pass: admin

![Connection parameters](/images/database_conexion.png "To connect Pgadmin to Postgres").