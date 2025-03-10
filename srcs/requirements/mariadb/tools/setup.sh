#!/bin/bash
set -e

echo "Starting MariaDB Setup Script ..."

if [ ! -d "/var/lib/mysql/mysql" ]; then
    echo "Initializing MariaDB data directory..."
    mysql_install_db --user=mysql --datadir=/var/lib/mysql
fi

mariadbd &
echo "Waiting for MariaDB to start..."
sleep 5

# ======================================================================================
# ======================================================================================

# Check if the WordPress database exists, if not, create it, along with the WordPress user
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


# ======================================================================================
# ======================================================================================

mysqladmin -u root -p${MYSQL_ROOT_PASSWORD} shutdown

# ======================================================================================
# ======================================================================================

echo "MariaDB setup completed. Starting MariaDB..."

exec "$@"

