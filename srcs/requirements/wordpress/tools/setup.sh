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
set -e

echo "Waiting for database connection..."

# Wait for MariaDB to be ready
while ! mysql -h maria-db -u ${WORDPRESS_USER} -p${WORDPRESS_PASSWORD} -e "USE ${WORDPRESS_DB_NAME};" 2>/dev/null; do
    echo "Database not ready yet. Retrying in 5 seconds..."
    sleep 5
done

echo "Database connection established!"

# Download WordPress core files if they are not present
if [ ! -f "wp-load.php" ]; then
    echo "Downloading WordPress core files..."
    wp core download --allow-root
fi

# Create wp-config.php if it does not exist
if [ ! -f "wp-config.php" ]; then
    echo "Creating WordPress configuration..."
    wp config create \
        --dbname="${WORDPRESS_DB_NAME}" \
        --dbuser="${WORDPRESS_USER}" \
        --dbpass="${WORDPRESS_PASSWORD}" \
        --dbhost="maria-db" \
        --allow-root
fi

# Install WordPress if not already installed
if ! wp core is-installed --allow-root; then
    echo "Installing WordPress..."
    wp core install \
        --url="${WP_URL}" \
        --title="${WP_TITLE}" \
        --admin_user="${WP_ADMIN_USER}" \
        --admin_password="${WP_ADMIN_PASS}" \
        --admin_email="${WP_ADMIN_EMAIL}" \
        --allow-root
    echo "WordPress installation complete!"
else
    echo "WordPress already installed!"
fi

echo "Starting PHP-FPM..."

exec "$@"

