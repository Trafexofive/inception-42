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
.PHONY: all build up down run logs clean fclean prune re rere rmvol netprune ls it exec

all: build

# ======================================== CONTAINER MANAGEMENT ========================================

build:
	@echo "Building containers..."
	@$(COMPOSE) build

no-cache:
	@echo "Building containers..."
	@$(COMPOSE) build --no-cache

up: build
	@echo "Starting containers in detached mode..."
	@$(COMPOSE) up -d

down:
	@echo "Stopping containers..."
	@$(COMPOSE) down

run: down no-cache # Build without cache for now
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

# Remove volumes and rebuild
rere: rmvol prune run

# Restart containers
re: down run

# Remove containers, images, and volumes used by the compose file
clean:
	@echo "Removing containers, images, and volumes..."
	@$(COMPOSE) down --volumes --rmi all

# Complete cleanup (containers, networks, images, build cache)
fclean: down
	@echo "Performing complete cleanup..."
	@$(COMPOSE) rm -f
	@make prune

# Prune Docker system (remove unused containers, networks, images)
prune: down
	@echo "Pruning Docker system..."
	@docker system prune -f

# Prune Docker networks
netprune:
	@echo "Pruning Docker networks..."
	@docker network prune -f

# Remove volumes and orphaned containers
rmvol:
	@echo "Removing volumes and orphaned containers..."
	@$(COMPOSE) down -v --remove-orphans

# Clean everything and rebuild
rebuild: fclean all

# Prevent errors for arguments passed to targets
%:
	@:
