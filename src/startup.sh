#!/usr/bin/env bash

#CONTAINER_GATEWAY=`/sbin/ip route|awk '/default/ { print $3 }'`

# Adding host machine hostname
#echo -e "\n# Hostname for gateway" >> /etc/hosts
#echo -e "${CONTAINER_GATEWAY}\tdocker.host.internal\n" >> /etc/hosts

/usr/bin/supervisord -n -c /etc/supervisor/supervisord.conf
