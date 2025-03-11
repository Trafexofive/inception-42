# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    setup.sh                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: mlamkadm <mlamkadm@student.42.fr>          +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2025/03/03 13:07:58 by mlamkadm          #+#    #+#              #
#    Updated: 2025/03/10 21:40:26 by mlamkadm         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

#!/bin/bash

echo "Starting PHP-FPM Setup Script ..."

echo "Giving Permissions to www-data user, creating necessary directories and files..."

mkdir -p /run/php
chown www-data:www-data /run/php
chmod 755 /run/php

chown -R www-data:www-data /var/www/wordpress
chmod -R 755 /var/www/wordpress

# ======================================================================================
# ======================================================================================

echo "Attempting to connect to database..."
timeout=15

while ! mysql -h maria-db -u ${WORDPRESS_USER} -p${WORDPRESS_PASSWORD} -e "USE ${WORDPRESS_DB_NAME}" 2>/dev/null; do
    ((timeout--))
    if [ $timeout -lt 1 ]; then
        echo "WARNING: Database connection timed out"
        exit 1
    fi
    echo "Database connection failed, retrying connection ..."
    sleep 1
done

# ======================================================================================
# ======================================================================================

echo "Database connection established!"

echo "Checking if WordPress is installed..."
if [ ! -f "wp-settings.php" ]; then
    echo "WP is not installed, Downloading WordPress..."
    wp core download --quiet
fi
echo "WordPress is installed!"

if [ ! -f "wp-config.php" ]; then
    echo "wordpress Config Missing, Creating WordPress config ..."
    wp config create \
        --dbname=${WORDPRESS_DB_NAME} \
        --dbuser=${WORDPRESS_USER} \
        --dbpass=${WORDPRESS_PASSWORD} \
        --dbhost=${WORDPRESS_DB_HOST}\
        --skip-check \
        --quiet
else 
    echo "WordPress Config already exists!"
fi

if ! wp core is-installed 2>/dev/null; then
    echo "WordPress Not installed, Installing WordPress..."
    wp core install \
        --url=${WP_URL} \
        --title="${WP_TITLE}" \
        --admin_user=${WP_ADMIN_USER} \
        --admin_password=${WP_ADMIN_PASS} \
        --admin_email=${WP_ADMIN_EMAIL} \
        --skip-email \
        --quiet

    echo "WordPress installed successfully!"
else 
    echo "WordPress is already installed!"
fi

# ======================================================================================
# ======================================================================================

if wp user get "$EXTRA_USERNAME" --field=ID --allow-root > /dev/null 2>&1; then
    echo "User with username '$EXTRA_USERNAME' already exists."
else 
  echo "Creating user with username '$EXTRA_USERNAME'..."
  wp user create "$EXTRA_USERNAME" "$EXTRA_EMAIL" --user_pass="$EXTRA_PASS" --role="$EXTRA_ROLE"
fi

# ======================================================================================
# ======================================================================================

wp theme install twentytwentyfour --allow-root
wp theme activate twentytwentyfour --allow-root

echo "PHP-FPM Setup complete"
echo "Starting PHP-FPM..."

exec "$@"
