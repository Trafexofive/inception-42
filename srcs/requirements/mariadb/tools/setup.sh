#!/bin/bash

# Date: 2025-02-28 23:09:30
# Author: Trafexofive

# Check if MariaDB data directory is already initialized
if [ ! -d "/var/lib/mysql/mysql" ]; then
    # If not initialized, run mysql_install_db
    mysql_install_db --user=mysql --datadir=/var/lib/mysql
fi

# Start MariaDB server in the background
mariadbd &

# Wait for MariaDB to start
echo "Waiting for MariaDB to start..."
sleep 3

# Check if the database has been secured already
if mysql -u root -e "SELECT 1" &>/dev/null; then
    echo "Setting up MariaDB security and WordPress user..."
    
    # Execute SQL commands directly
    mysql -u root <<EOF
ALTER USER 'root'@'localhost' IDENTIFIED BY '$MYSQL_ROOT_PASSWORD';
DELETE FROM mysql.user WHERE User='';
DELETE FROM mysql.user WHERE User='root' AND Host NOT IN ('localhost', '127.0.0.1', '::1');
DROP DATABASE IF EXISTS test;
DELETE FROM mysql.db WHERE Db='test' OR Db='test\\_%';
CREATE DATABASE IF NOT EXISTS $WORDPRESS_DB_NAME;
CREATE USER '$WORDPRESS_USER'@'%' IDENTIFIED BY '$WORDPRESS_PASSWORD';
GRANT ALL PRIVILEGES ON $WORDPRESS_DB_NAME.* TO '$WORDPRESS_USER'@'%';
FLUSH PRIVILEGES;
EOF
    echo "MariaDB security setup and WordPress user creation completed."
else
    echo "MariaDB is already secured or cannot be accessed without password."
fi

mysqladmin shutdown -p$MYSQL_ROOT_PASSWORD 


# Keep the script running to keep container alive
echo "Setup complete, keeping MariaDB running..."

exec $@
