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
