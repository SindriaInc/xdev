#!/usr/bin/env bash

#CONTAINER_GATEWAY=`/sbin/ip route|awk '/default/ { print $3 }'`

# Adding host machine hostname
#echo -e "\n# Hostname for gateway" >> /etc/hosts
#echo -e "${CONTAINER_GATEWAY}\tdocker.host.internal\n" >> /etc/hosts

# Configuring email relay
#sed -i -e -r "s|rewriteDomain=([\w\.\-]+)|rewriteDomain=${SINDRIA_APP_DOMAIN}|g" /etc/ssmtp/ssmtp.conf
#sed -i -e -r "s|hostname=([\w\.\-]+)|hostname=${SINDRIA_APP_DOMAIN}|g" /etc/ssmtp/ssmtp.conf

# Adding variables to php-fpm pool configuration
#sed -i -e "s|\[@@POOL_NAME@@\]|\[${HOSTNAME}-php-fpm-pool\]|g" /etc/php/${SINDRIA_PHP_VERSION}/fpm/pool.d/sindria.conf
#sed -i -e -r "s|pm.max_children = ([0-9]+)|pm.max_children = ${SINDRIA_PHP_PM_MAX_CHILDREN}|g" /etc/php/${SINDRIA_PHP_VERSION}/fpm/pool.d/sindria.conf

# Copying nginx virtualhost(s) configuration(s)
#cp /home/sindria/config/nginx/sites/*.conf /etc/nginx/sites/

# Check if php.ini config exists
#if [ -e /home/sindria/config/php/fpm/php.ini ]; then
#    cp /home/sindria/config/php/fpm/php.ini /etc/php/${SINDRIA_PHP_VERSION}/fpm/php.ini
#fi

# Copying cron.d configuration
#cp /home/sindria/config/cron.d/* /etc/cron.d/
#chown root:root /etc/cron.d/*
#chmod 644 /etc/cron.d/*

#chown -R sindria:sindria /var/www/app
# Launch composer install
#su - sindria -s /bin/bash -c 'cd /var/www/app; composer install --optimize-autoloader --no-dev'

/usr/bin/supervisord -n -c /etc/supervisor/supervisord.conf
