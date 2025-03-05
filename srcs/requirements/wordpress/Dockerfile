# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Dockerfile                                         :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: mlamkadm <mlamkadm@student.42.fr>          +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2025/01/13 19:00:37 by mlamkadm          #+#    #+#              #
#    Updated: 2025/03/01 06:13:24 by mlamkadm         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

FROM debian:buster

RUN apt-get update -y \
  && apt-get upgrade -y \
  && apt-get install -y vim wget php php-fpm php-mysql php-xml php-mbstring mariadb-client


RUN sed -i "s|/run/php/php7.3-fpm.sock|9000|g" /etc/php/7.3/fpm/pool.d/www.conf \
    && mkdir -p /run/php \
    && chown www-data:www-data /run/php \
    && chmod 755 /run/php


RUN wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar\
    && chmod +x wp-cli.phar \
    && mv wp-cli.phar /bin/wp


COPY . .

WORKDIR /var/www/wordpress


RUN chmod +x /tools/setup.sh

ENTRYPOINT ["bash", "/tools/setup.sh" ]

CMD [ "php-fpm7.3", "-F" ]
