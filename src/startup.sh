#!/usr/bin/env bash


# Override default sindria user password by env
if [ "$DEFAULT_SINDRIA_USER_PASSWORD" != "sindria" ]; then
    echo "sindria:${DEFAULT_SINDRIA_USER_PASSWORD}" | chpasswd
fi


# Override host user uid by env
if [ "$HOST_USER_UID" != "1000" ]; then
    usermod -u $HOST_USER_UID sindria && groupmod sindria -g $HOST_USER_UID
fi


# Override docker host uid by env
if [ "$HOST_DOCKER_GROUP_UID" != "998" ]; then
    groupmod -g ${HOST_DOCKER_GROUP_UID} docker
fi


# Override timezone by env
if [ "$TZ" != "Europe/Rome" ]; then
    ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone
fi


# Custom I3 configuration
if [ -f "/home/sindria/config/i3/config" ]; then
  cp /home/sindria/config/i3/config /home/sindria/.config/i3/config
fi


su sindria -c "export DISPLAY=$DISPLAY && /usr/bin/i3"