
NAME = srcs/docker-compose.yml
COMPOSE = docker-compose -f $(NAME)

all: build

# ======================================== GENERAL PURPOSE ========================================

build: 
	$(COMPOSE) build

run: down build
	$(COMPOSE) up -d
	$(COMPOSE) logs -f

down:
	$(COMPOSE) down

logs:
	$(COMPOSE) logs -f

it: 
	$(COMPOSE) exec $(filter-out $@, $(MAKECMDGOALS)) /bin/bash

exec: 
	$(COMPOSE) exec $(filter-out $@, $(MAKECMDGOALS))


ls:
	@echo "Containers:"
	@$(COMPOSE) ps
	@echo "Volumes:"
	@docker volume ls
	@echo "images:"
	@$(COMPOSE) images

# runit: run 
# 	$(compose) exec $(filter-out $@, $(makecmdgoals)) /bin/bash
  

# ======================================== CLEANING ========================================
# clean :

rere: rmvol prune run

re: down run

clean:
	docker-compose -f $(NAME) down --volumes --rmi all


prune:
	docker system prune -af


# kill-all:
# 	docker kill $(docker ps -aq)
#
# rmi: kill-all
# 	docker image rm $(docker images -aq)

# Basic cleanup (removes containers, images, build cache, networks)
# docker system prune -f

# Advanced cleanup (includes volumes)

netprune:
	docker network prune -f

rmvol:
	$(COMPOSE) down -v --remove-orphans

re: fclean all

.PHONY: all build clean fclean detach re


# ======================================== TODO ========================================
# make a compose project -p.
#
