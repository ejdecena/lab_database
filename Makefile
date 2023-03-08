#!/usr/bin/env make -f
SHELL = /bin/bash

include .env

.ONESHELL:

install:
	@clear
	@echo "* Installing docker..."
	@./install-docker.sh
run:
	@clear
	@echo "* Running..."
	@docker compose -p $(PROJECT_NAME) -f docker-compose.yml up -d
	@echo ""
	@echo "*** PG ADMIN 4:"
	@echo "GO TO http://$(PGADMIN_ADDRESS):$(PGADMIN_PORT)"
	@echo "Username: $(PGADMIN_DEFAULT_EMAIL)"
	@echo "Password: $(PGADMIN_DEFAULT_PASSWORD)"
	@docker inspect postgres_db | grep -G '\"IPAddress\": \"1' | xargs | sed -r 's/(,)+//g'
	@echo ""
ip:
	@clear
	@docker inspect postgres_db | grep -G '\"IPAddress\": \"1' | xargs | sed -r 's/(,)+//g'
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