#!/usr/bin/env make -f
SHELL = /bin/bash

include .env

.ONESHELL:

install:
	@clear
	@echo "* Installing docker..."
	@bash install-docker.sh
run:
	@clear
	@echo "* Running..."
	@docker compose -p $(PROJECT_NAME) -f docker-compose.yml up -d
	@echo ""
	@echo "*** PG ADMIN 4:"
	@echo "GO TO http://$(PGADMIN_ADDRESS):$(PGADMIN_PORT)"
	@echo "Username: user@gmail.com"
	@echo "Password: $(PGADMIN_DEFAULT_PASSWORD)"
	@echo ""
# @chown -R 5050:5050 ./storage
	@docker exec -it -u root pgadmin4 chown -R 5050:5050 /var/lib/pgadmin/storage
psql:
	@clear
	@echo "* Postgres."
	@docker exec -it postgres_db psql -d $(POSTGRES_DB) -U $(POSTGRES_USER)
logs:
	@clear
	@docker compose -p $(PROJECT_NAME) -f docker-compose.yml logs -f
stop:
	@clear
	@echo "* Stoping..."
	@docker compose -p $(PROJECT_NAME) -f docker-compose.yml down
	@echo ""
restart: stop run
	@echo "Restarting..."
reset:
	@clear
	@echo "* Reseting database..."
	@sudo docker volume rm $(PROJECT_NAME)_postgres_data $(PROJECT_NAME)_pgadmin_data