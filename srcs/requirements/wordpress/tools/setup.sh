# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    setup.sh                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: mlamkadm <mlamkadm@student.42.fr>          +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2025/03/03 13:07:58 by mlamkadm          #+#    #+#              #
#    Updated: 2025/03/03 13:07:58 by mlamkadm         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

#!/bin/bash
set -eo pipefail

# Create PHP-FPM runtime directory
mkdir -p /run/php
chown www-data:www-data /run/php
chmod 755 /run/php

# Wait for MariaDB (30s timeout)
timeout=30
while ! mysql -h maria-db -u ${WORDPRESS_USER} -p${WORDPRESS_PASSWORD} -e "USE ${WORDPRESS_DB_NAME}" 2>/dev/null; do
    ((timeout--))
    if [ $timeout -lt 1 ]; then
        echo "ERROR: Database connection timed out"
        exit 1
    fi
    sleep 1
done

echo "Database connection established!"

# Install WordPress core if not present
if [ ! -f "wp-settings.php" ]; then
    echo "Downloading WordPress..."
    wp core download --quiet
fi

# Create config if missing
if [ ! -f "wp-config.php" ]; then
    echo "Creating WordPress config..."
    wp config create \
        --dbname=${WORDPRESS_DB_NAME} \
        --dbuser=${WORDPRESS_USER} \
        --dbpass=${WORDPRESS_PASSWORD} \
        --dbhost=maria-db \
        --skip-check \
        --quiet
fi

# Install WordPress if not installed
if ! wp core is-installed 2>/dev/null; then
    echo "Installing WordPress..."
    wp core install \
        --url=${WP_URL} \
        --title="${WP_TITLE}" \
        --admin_user=${WP_ADMIN_USER} \
        --admin_password=${WP_ADMIN_PASS} \
        --admin_email=${WP_ADMIN_EMAIL} \
        --skip-email \
        --quiet

    echo "WordPress installed successfully!"
fi

# Ensure proper permissions
chown -R www-data:www-data /var/www/wordpress
chmod -R 755 /var/www/wordpress

echo "Script End: Starting PHP-FPM..."

exec "$@"
