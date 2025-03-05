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

sleep 10

# Create www-data directories and set permissions
mkdir -p /var/www/wordpress
chown www-data:www-data /var/www/wordpress
cd /var/www/wordpress

# Wait for database to be ready
echo "Waiting for database connection..."
max_attempts=10
attempts=3

# First download WordPress core files if they don't exist
if [ ! -f "wp-load.php" ]; then
    echo "Downloading WordPress core files..."
    wp core download --allow-root
fi

# Create wp-config.php if it doesn't exist
if [ ! -f "wp-config.php" ]; then
    echo "Creating WordPress configuration..."
    wp config create \
        --dbname="$WORDPRESS_DB_NAME" \
        --dbuser="$WORDPRESS_USER" \
        --dbpass="$WORDPRESS_PASSWORD" \
        --dbhost="maria-db" \
        --allow-root
fi

# Wait for database to be ready
while ! wp db check --allow-root 2>/dev/null; do
    sleep 2
    attempts=$((attempts+1))
    echo "Waiting for database connection... Attempt $attempts/$max_attempts"
    
    if [ $attempts -ge $max_attempts ]; then
        echo "Could not connect to database after $max_attempts attempts. Exiting."
        exit 1
    fi
done

echo "Database connection established!"

# Install WordPress if not already installed
wp core is-installed --allow-root
if [ $? -ne 0 ]; then
    echo "Installing WordPress..."
    wp core install \
        --url="https://localhost" \
        --title="$WP_TITLE" \
        --admin_user="$WP_ADMIN_USER" \
        --admin_password="$WP_ADMIN_PASS" \
        --admin_email="$WP_ADMIN_EMAIL" \
        --allow-root
    
    echo "WordPress installation complete!"
else
    echo "WordPress already installed!"
    
fi

# Fix permissions for all WordPress files
chown -R www-data:www-data /var/www/wordpress

# Execute the command passed to this script
echo "Starting PHP-FPM..."

exec "$@"
