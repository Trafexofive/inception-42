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
	docker-compose -f $(NAME) exec maria /bin/sh

ssh: all
	docker-compose -f $(NAME) exec backend /bin/sh

backend:
	docker-compose -f $(NAME) up backend

maria:
	docker-compose -f $(NAME) up maria

nginx:
	docker-compose -f $(NAME) up nginx

build: 
	docker-compose -f $(NAME) build

clean :
	docker-compose -f $(NAME) down

fclean: clean
	docker-compose -f $(NAME) down --volumes --rmi all

detach: all
	docker-compose -f $(NAME) up -d

re: fclean all

.PHONY: all build clean fclean detach re
