#!/bin/bash
set -euo pipefail
export DEBIAN_FRONTEND=noninteractive
 
RDS_HOST="${rds_host}"
RDS_MASTER_USER="${username}"
RDS_MASTER_PASS="${password}"
DB_NAME="wordpress_db"
DB_USER="wp_user"
DB_PASS="wp_pass"
 
# System, Apache, PHP, MySQL client
apt-get update -y && apt upgrade -y
apt-get install -y apache2 mysql-client php php-mysql php-gd php-mbstring php-xml php-curl
systemctl enable --now apache2
 
# WordPress
cd /var/www/html
wget -q https://wordpress.org/latest.tar.gz && tar -xzf latest.tar.gz
cp -r wordpress/* . && rm -rf wordpress latest.tar.gz
chown -R www-data:www-data /var/www/html && chmod -R 755 /var/www/html

# Create DB and user on RDS
mysql -h "$RDS_HOST" -u "$RDS_MASTER_USER" -p"$RDS_MASTER_PASS" <<EOF
CREATE DATABASE IF NOT EXISTS \`$DB_NAME\`;
CREATE USER IF NOT EXISTS '$DB_USER'@'%' IDENTIFIED BY '$DB_PASS';
GRANT ALL PRIVILEGES ON \`$DB_NAME\`.* TO '$DB_USER'@'%';
FLUSH PRIVILEGES;
EOF
 
# Configure WordPress
cp wp-config-sample.php wp-config.php
sed -i "s/database_name_here/$DB_NAME/" wp-config.php
sed -i "s/username_here/$DB_USER/"      wp-config.php
sed -i "s/password_here/$DB_PASS/"      wp-config.php
sed -i "s/localhost/$RDS_HOST/"         wp-config.php

sudo rm -f /var/www/html/index.html
 
echo "Done. Visit your EC2 public IP to finish the WordPress setup wizard."