# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: mlamkadm <mlamkadm@student.42.fr>          +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2025/03/08 14:45:36 by mlamkadm          #+#    #+#              #
#    Updated: 2025/03/08 14:45:36 by mlamkadm         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

# ======================================== VARIABLES ========================================

NAME = srcs/docker-compose.yml
COMPOSE = docker-compose -f $(NAME)

# ======================================== MAIN TARGETS ========================================
#
.PHONY: all build rebuild no-cache up down run logs it exec ls clean fclean re rmextern
all: build

# ======================================== CONTAINER MANAGEMENT ========================================

build:
	@echo "Building containers..."
	@$(COMPOSE) build

rebuild: fclean run

no-cache:
	@echo "Building containers..."
	@$(COMPOSE) build --no-cache

up: build
	@echo "Starting containers in detached mode..."
	@$(COMPOSE) up -d

down:
	@echo "Stopping containers..."
	@$(COMPOSE) down

run: down
	@echo "Starting containers and following logs..."
	@$(COMPOSE) up -d
	@$(COMPOSE) logs -f

logs:
	@echo "Displaying logs..."
	@$(COMPOSE) logs -f

it:
	@$(COMPOSE) exec $(filter-out $@, $(MAKECMDGOALS)) /bin/bash

exec:
	@$(COMPOSE) exec $(filter-out $@, $(MAKECMDGOALS))

ls:
	@echo "===== Containers ====="
	@$(COMPOSE) ps
	@echo "\n===== Volumes ====="
	@docker volume ls
	@echo "\n===== Images ====="
	@$(COMPOSE) images

# ======================================== CLEANING ========================================

re: down run

clean: down
	@echo "Removing containers, images, and volumes..."
	@$(COMPOSE) down --volumes --remove-orphans --rmi all

fclean: rmextern clean
	@echo "Performing complete cleanup..."
	@$(COMPOSE) rm -f
	@make prune

prune: clean netprune
	@echo "Pruning Docker system..."
	@docker system prune -af

netprune:
	@echo "Pruning Docker networks..."
	@docker network prune -f


rmextern: down
	@echo "removing externally bounded volumes"
	@sudo rm -rf /home/mlamkadm/data
	@mkdir -p /home/mlamkadm/data/maria-db
	@mkdir -p /home/mlamkadm/data/wordpress

