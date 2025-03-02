# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Dockerfile                                         :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: mlamkadm <mlamkadm@student.42.fr>          +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2025/01/09 21:51:53 by mlamkadm          #+#    #+#              #
#    Updated: 2025/03/01 05:54:19 by mlamkadm         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

FROM debian:buster

EXPOSE 9000

COPY ./tools/default.conf /etc/nginx/conf.d/

RUN apt-get update \
  && apt-get upgrade -y \
&& apt-get install -y vim nginx openssl 

RUN mkdir -p /etc/nginx/ssl \
    && chown -R www-data:www-data /etc/nginx/ssl \
    && chmod 755 /etc/nginx/ssl

RUN openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
    -keyout /etc/nginx/ssl/cert.key \
    -out /etc/nginx/ssl/cert.crt\
    -subj "/C=MA/ST=settat/L=khouribga/O=1337/OU=1337/CN=mlamkadm.42.fr"

RUN mkdir -p /var/www/wordpress

RUN chown -R www-data:www-data /var/www/wordpress\
    && chmod 755 /var/www/wordpress

ENTRYPOINT ["nginx", "-g", "daemon off;"]

#CMD [ "-g", "daemon off;" ]

# ENTRYPOINT ["sleep", "infinity"]


