# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Dockerfile                                         :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: mlamkadm <mlamkadm@student.42.fr>          +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2025/03/11 21:26:20 by mlamkadm          #+#    #+#              #
#    Updated: 2025/03/11 21:26:20 by mlamkadm         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #


FROM debian:bullseye

RUN apt-get update && \
    apt-get install -y nginx openssl && \
    rm -rf /var/lib/apt/lists/*

RUN mkdir -p /etc/nginx/ssl && \
    \
    openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
    -keyout /etc/nginx/ssl/cert.key \
    -out /etc/nginx/ssl/cert.crt \
    -subj "/C=MO/ST=Settat/L=Khouribga/O=42/OU=1337/CN=mlamkadm.42.fr"

COPY ./tools/default.conf /etc/nginx/sites-enabled/default

CMD ["nginx", "-g", "daemon off;"]

