# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Dockerfile                                         :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: mlamkadm <mlamkadm@student.42.fr>          +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2025/01/13 17:13:27 by mlamkadm          #+#    #+#              #
#    Updated: 2025/01/13 17:13:27 by mlamkadm         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

FROM debian:bullseye

RUN apt-get update
RUN apt-get install -y mariadb-server

EXPOSE 3306

# VOLUME data/db

# CMD ["mariadbd"]

# CMD ["tail", "-f", "/bin/bash"]

ENTRYPOINT ["tail", "-f", "/bin/bash"]


