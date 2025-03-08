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

# Install MariaDB server without unnecessary upgrades
RUN apt-get update && \
    apt-get install -y mariadb-server && \
    rm -rf /var/lib/apt/lists/*

# Configure MariaDB to listen on all interfaces
RUN sed -i 's/127.0.0.1/0.0.0.0/g' /etc/mysql/mariadb.conf.d/50-server.cnf

# Ensure runtime directory exists and permissions are correct
RUN mkdir -p /run/mysqld && chown -R mysql:mysql /run/mysqld

# Copy custom setup script and related files (make sure .dockerignore excludes tools if needed)
COPY . /app

WORKDIR /app/tools

ENTRYPOINT [ "bash", "setup.sh" ]
CMD [ "mariadbd" ]
