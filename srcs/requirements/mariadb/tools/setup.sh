#!/bin/bash
set -e

echo "Starting MariaDB setup..."

# Initialize the MariaDB data directory if needed
if [ ! -d "/var/lib/mysql/mysql" ]; then
    echo "Initializing MariaDB data directory..."
    mysql_install_db --user=mysql --datadir=/var/lib/mysql
fi

# Start MariaDB server in the background
mariadbd &
echo "Waiting for MariaDB to start..."
sleep 5

# Check if the WordPress database exists
if ! mysql -u root -p${MYSQL_ROOT_PASSWORD} -e "USE ${WORDPRESS_DB_NAME}" 2>/dev/null; then
    echo "Setting up MariaDB security and WordPress database..."
    mysql -u root -p${MYSQL_ROOT_PASSWORD} <<EOF
ALTER USER 'root'@'localhost' IDENTIFIED BY '${MYSQL_ROOT_PASSWORD}';
DELETE FROM mysql.user WHERE User='';
DELETE FROM mysql.user WHERE User='root' AND Host NOT IN ('localhost', '127.0.0.1', '::1');
DROP DATABASE IF EXISTS test;
DELETE FROM mysql.db WHERE Db='test' OR Db='test\\_%';
CREATE DATABASE IF NOT EXISTS ${WORDPRESS_DB_NAME};
EOF
    echo "Database setup completed."
else
    echo "WordPress database already exists. Skipping setup."
fi

# Check if the WordPress user exists
if ! mysql -u root -p${MYSQL_ROOT_PASSWORD} -e "SELECT User FROM mysql.user WHERE User='${WORDPRESS_USER}'" 2>/dev/null | grep -q "${WORDPRESS_USER}"; then
    echo "Creating WordPress user..."
    mysql -u root -p${MYSQL_ROOT_PASSWORD} <<EOF
CREATE USER '${WORDPRESS_USER}'@'%' IDENTIFIED BY '${WORDPRESS_PASSWORD}';
GRANT ALL PRIVILEGES ON ${WORDPRESS_DB_NAME}.* TO '${WORDPRESS_USER}'@'%';
FLUSH PRIVILEGES;
EOF
    echo "User setup completed."
else
    echo "WordPress user already exists. Skipping user creation."
fi

# Shutdown the background server to let CMD restart it properly
mysqladmin -u root -p${MYSQL_ROOT_PASSWORD} shutdown

echo "Setup complete. Starting MariaDB..."

exec "$@"
