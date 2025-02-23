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
	docker-compose exec maria-db /bin/sh

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

prune:
	docker system prune

prune: kill-all
	docker system prune

re: fclean all

.PHONY: all build clean fclean detach re
