# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    setup.sh                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: mlamkadm <mlamkadm@student.42.fr>          +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2025/03/01 01:23:44 by mlamkadm          #+#    #+#              #
#    Updated: 2025/03/01 06:17:47 by mlamkadm         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

#!/bin/bash

sleep 5
# checkers for the the installation of wp.

# Core Initialization
wp core download --allow-root
sleep 1

wp core config --dbname="$WORDPRESS_DB_NAME" --dbuser="$WORDPRESS_USER" --dbpass="$WORDPRESS_PASSWORD" --dbhost="maria-db" --skip-check  --allow-root

sleep 1
wp core install --url="$WP_URL" --title="$WP_TITLE" --admin_user="$WORDPRESS_USER" --admin_password="$WORDPRESS_PASSWORD" --admin_email="$WP_ADMIN_EMAIL" --allow-root

#adding the second user

exec $@



