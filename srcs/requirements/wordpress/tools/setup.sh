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
# Create www-data directories and set permissions


sleep 5
# Wait for database to be ready
echo "Waiting for database connection..."
max_attempts=3
attempts=1

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

# Install WordPress if not already installed
wp core is-installed --allow-root
if [ $? -ne 0 ]; then
    echo "Installing WordPress..."
    wp core install \
        --url="localhost" \ # mlamkadm.42.fr
        --title="$WP_TITLE" \
        --admin_user="$WP_ADMIN_USER" \
        --admin_password="$WP_ADMIN_PASS" \
        --admin_email="$WP_ADMIN_EMAIL" \
        --allow-root
    
    echo "WordPress installation complete!"
else
    echo "WordPress already installed!"
    
fi



# Execute the command passed to this script
echo "Starting PHP-FPM..."

exec "$@"
