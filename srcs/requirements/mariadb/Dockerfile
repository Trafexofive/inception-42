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

RUN apt-get update  && \
    apt-get upgrade -y && \
    apt-get install -y mariadb-server

RUN sed -i 's/127.0.0.1/0.0.0.0/g' /etc/mysql/mariadb.conf.d/50-server.cnf

RUN mkdir -p /run/mysqld && \
    chown -R mysql:mysql /run/mysqld && \
    chmod +x /run/mysqld

COPY . .

WORKDIR /tools


ENTRYPOINT [ "bash", "setup.sh" ]

# CMD [ "sleep", "infinity" ]

CMD [ "mariadbd" ]


