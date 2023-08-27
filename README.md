# Database Laboratory.


This repository is intended to be a platform or academic laboratory for database design and implementation. This laboratory is based on Docker technology to lift PostgreSQL 15 and pgAdmin4 services in a Linux environment, mainly.


### To install:
```bash
$ git clone https://github.com/ejdecena/lab_database
$ cd lab_database
$ sudo apt install make
$ make install
$ sudo usermod -aG docker $USER
$ sudo service docker start
close the terninal.
```

## To run the laboratory:
```bash
$ make run
```

* GO TO http://```{PGADMIN_ADDRESS}```:```{PGADMIN_PORT}```
* Username: ```user@gmail.com```.
* Password: ```{PGADMIN_DEFAULT_PASSWORD}``` in ```.env``` file.

## To login in pgAdmin4:
![Login Pgadmin parameters](/images/login.png "Login Pgadmin parameters").

## To register a server in pgAdmin4:
Al iniciar sesión por primera vez, habrá que registrar un servidor. Para ello, hacer click derecho sobre la opción Servers:

![Register Server](/images/register_server.png "Register Server").

## To connect pgAdmin4 to PostgreSQL:

The data for the connection are:

* Host name / address: ```postgres_db```
* Port: ```5432```
* Database: ```{POSTGRES_DB}``` in ```.env``` file.
* Username: ```{POSTGRES_USER}``` in ```.env``` file.
* Pass: ```{POSTGRES_PASSWORD}``` in ```.env``` file.

![Server Connection](/images/server_connection.png "Server Connection").

## To access the PostgreSQL container:
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