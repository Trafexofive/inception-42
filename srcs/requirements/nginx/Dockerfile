# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Dockerfile                                         :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: mlamkadm <mlamkadm@student.42.fr>          +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2025/01/09 21:51:53 by mlamkadm          #+#    #+#              #
#    Updated: 2025/03/02 01:39:59 by mlamkadm         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

FROM debian:buster

EXPOSE 443

RUN apt-get update \
    && apt-get upgrade -y \
    && apt-get install -y nginx openssl 

RUN mkdir -p /etc/nginx/ssl \
    && chown -R www-data:www-data /etc/nginx/ \
    && chmod -R 755 /etc/nginx/
    
RUN openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
    -keyout /etc/nginx/ssl/cert.key \
    -out /etc/nginx/ssl/cert.crt\
    -subj "/C=MA/ST=settat/L=khouribga/O=1337/OU=1337/CN=mlamkadm.42.fr"
    
COPY --user=www-data ./tools/default.conf /etc/nginx/sites-enabled/

# RUN mkdir -p /var/www/wordpress \
#     && chown -R www-data:www-data /var/www/wordpress \
#     && chmod 755 /var/www/wordpress

ENTRYPOINT ["nginx", "-g", "daemon off;"]

# CMD [ "-g", "daemon off;" ]/

#  ENTRYPOINT ["sleep", "infinity"]


