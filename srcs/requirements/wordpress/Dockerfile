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

FROM debian:bullseye

# Install required packages
RUN apt-get update && \
    apt-get install -y wget curl php7.4-fpm php7.4-mysql php7.4-xml php7.4-mbstring mariadb-client && \
    rm -rf /var/lib/apt/lists/*

# Update PHP-FPM socket configuration to use TCP port 9000
RUN sed -i "s|/run/php/php7.4-fpm.sock|9000|g" /etc/php/7.4/fpm/pool.d/www.conf && \
    mkdir -p /run/php && \
    chown www-data:www-data /run/php && \
    chmod 755 /run/php

# Create and set permissions for PHP-FPM log directory
RUN mkdir -p /var/log/php7.4-fpm && \
    touch /var/log/php7.4-fpm.log && \
    chown -R www-data:www-data /var/log/php7.4-fpm && \
    chmod -R 755 /var/log/php7.4-fpm && \
    chown www-data:www-data /var/log/php7.4-fpm.log && \
    chmod 644 /var/log/php7.4-fpm.log

# Install WP-CLI
RUN wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar && \
    chmod +x wp-cli.phar && \
    mv wp-cli.phar /usr/local/bin/wp

# Copy sources (including the setup script) into the container
COPY . /app

RUN chmod +x /app/tools/setup.sh

# # Switch to non-root user for running WordPress
USER www-data

WORKDIR /var/www/wordpress

ENTRYPOINT ["bash", "/app/tools/setup.sh"]

CMD [ "php-fpm7.4", "-F" ]
