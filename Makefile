# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: mlamkadm <mlamkadm@student.42.fr>          +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2025/01/09 21:48:03 by mlamkadm          #+#    #+#              #
#    Updated: 2025/01/09 21:48:03 by mlamkadm         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

NAME = srcs/docker-compose.yml

all: build

logs: all
	docker-compose -f $(NAME) logs -f

maria-it: all
	docker-compose exec maria-db /bin/bash

nginx-it: all
	docker-compose exec nginx /bin/bash

ssh: all
	docker-compose -f $(NAME) exec backend /bin/sh

backend:
	docker-compose -f $(NAME) up backend

maria:
	docker-compose -f $(NAME) up maria-db -it bin/bash

nginx:
	docker-compose -f $(NAME) up nginx

build: 
	docker compose -f $(NAME) build

clean :
	docker-compose -f $(NAME) down

fclean: clean
	docker-compose -f $(NAME) down --volumes --rmi all

detach: all
	docker-compose -f $(NAME) up -d

kill-all:
	docker kill $(docker ps -aq)

rmi: kill-all
	docker image rm $(docker images -aq)

run:
	docker-compose -f $(NAME) up -d

# prune:
# 	docker system prune

prune: kill-all
	docker system prune

# Basic cleanup (removes containers, images, build cache, networks)
# docker system prune -f

# Advanced cleanup (includes volumes)
# docker system prune --volumes -af

re: fclean all

.PHONY: all build clean fclean detach re
