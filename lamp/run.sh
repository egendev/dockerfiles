#!/bin/bash

# Make application temp directory writable
chown www-data:www-data /var/www/html/temp -R
chmod 777 /var/www/html/temp

# Make temp dir for integrations tests writable
if [ -d "/var/www/html/tests/Integration/temp" ]; then
    chown www-data:www-data /var/www/html/tests/Integration/temp -R
    chmod 777 /var/www/html/tests/Integration/temp
fi

# Make home directory writable
chown www-data:www-data /var/www -R
chmod 777 /var/www

# Enable bash history
touch /var/www/.bash_history
chown www-data:www-data /var/www/.bash_history

# Enable mod_rewrite
if [ "$ALLOW_OVERRIDE" = "**False**" ]; then
    unset ALLOW_OVERRIDE
else
    sed -i "s/AllowOverride None/AllowOverride All/g" /etc/apache2/apache2.conf
    a2enmod rewrite
fi

source /etc/apache2/envvars
tail -F /var/log/apache2/* &

service mysql start
exec apache2 -D FOREGROUND
