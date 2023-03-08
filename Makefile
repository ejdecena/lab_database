#!/usr/bin/env make -f
SHELL = /bin/bash

include .env

.ONESHELL:

run:
	@clear
	@echo "* Running..."
	@docker compose -p $(LAB_NAME) -f docker-compose.yml up -d
psql:
	@clear
	@echo "* Postgres."
	@docker exec -it postgres_db psql -d $(POSTGRES_DB) -U $(POSTGRES_USER)
logs:
	@clear
	@docker compose -p $(LAB_NAME) -f docker-compose.yml logs -f
stop:
	@clear
	@echo "* Stoping..."
	@docker compose -p $(LAB_NAME) -f docker-compose.yml down
restart: stop run
	@echo "Restarting..."
reset:
	@clear
	@echo "* Reseting database..."
	@sudo docker volume rm $(LAB_NAME)_postgres_data $(LAB_NAME)_pgadmin_data