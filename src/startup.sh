#!/usr/bin/env bash

#CONTAINER_GATEWAY=`/sbin/ip route|awk '/default/ { print $3 }'`

# Adding host machine hostname
#echo -e "\n# Hostname for gateway" >> /etc/hosts
#echo -e "${CONTAINER_GATEWAY}\tdocker.host.internal\n" >> /etc/hosts

# Add custom hosts
if [ ! -f "/home/sindria/config/etc/.done" ]; then
  cat /home/sindria/config/etc/hosts >> /etc/hosts
  touch /home/sindria/config/etc/.done
fi  

su sindria -c "export DISPLAY=$DISPLAY && /usr/bin/i3"
