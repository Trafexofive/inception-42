# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    setup.sh                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: mlamkadm <mlamkadm@student.42.fr>          +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2025/03/11 21:25:04 by mlamkadm          #+#    #+#              #
#    Updated: 2025/03/11 21:25:04 by mlamkadm         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

#!/bin/bash

echo "Starting MariaDB Setup Script ..."

if [ ! -d "/var/lib/mysql/mysql" ]; then
    echo "No MariaDB dir found, Initializing MariaDB data directory..."
    mysql_install_db --user=mysql --datadir=/var/lib/mysql
else
    echo "MariaDB data directory already exists. Skipping initialization."
fi

# ======================================================================================
# ======================================================================================

mariadbd &
echo "Waiting for MariaDB to start..."

timeout=15
while ! mysqladmin ping -u root --silent; do
    sleep 1
    ((timeout--))
    if [ $timeout -le 0 ]; then
        echo "MariaDB startup timed out!"
        exit 1
    fi
    echo "MariaDB is not ready yet. Retrying connection..."
done


# ======================================================================================
# ======================================================================================

if ! mysql -u root -p${MYSQL_ROOT_PASSWORD} -e "USE ${WORDPRESS_DB_NAME}" 2>/dev/null; then
    echo "Setting up MariaDB security and WordPress database..."
    mysql -u root <<EOF
CREATE DATABASE IF NOT EXISTS ${WORDPRESS_DB_NAME};
CREATE USER IF NOT EXISTS '${WORDPRESS_USER}'@'%' IDENTIFIED BY '${WORDPRESS_PASSWORD}';
GRANT ALL PRIVILEGES ON ${WORDPRESS_DB_NAME}.* TO '${WORDPRESS_USER}'@'%' IDENTIFIED BY '${WORDPRESS_PASSWORD}';
FLUSH PRIVILEGES;
EOF
    echo "Database setup completed."
else
    echo "WordPress database already exists. Skipping setup."
fi

# ======================================================================================
# ======================================================================================

mysqladmin -u root -p${MYSQL_ROOT_PASSWORD} shutdown

# ======================================================================================
# ======================================================================================

echo "MariaDB setup completed. Starting MariaDB..."

exec "$@"

