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


FROM debian

WORKDIR .

VOLUME [ "/db-data" ]

EXPOSE 3306

COPY . .


RUN apt update && apt upgrade

RUN apt install -y mariadb-server
RUN mysql_secure_installation

# RUN 


CMD [ "./main.sh" ]

