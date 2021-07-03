#!/usr/bin/env bash

# Cleanup lock files
rm -Rf /tmp/i3-sindria.*
rm -f /tmp/X*.lock
rm -Rf /tmp/.X11-unix/X*

# Override default sindria user password by env
if [ "${DEFAULT_SINDRIA_USER_PASSWORD}" != "sindria" ]; then
    echo "${SINDRIA_USER}:${DEFAULT_SINDRIA_USER_PASSWORD}" | chpasswd
fi


# Override host user uid by env
if [ "${HOST_USER_UID}" != "1000" ]; then
    usermod -u $HOST_USER_UID ${SINDRIA_USER} && groupmod ${SINDRIA_USER} -g $HOST_USER_UID
fi


# Override docker host uid by env
if [ "${HOST_DOCKER_GROUP_UID}" != "975" ]; then
    groupmod -g ${HOST_DOCKER_GROUP_UID} docker
fi


# Override timezone by env
if [ "${TZ}" != "Europe/Rome" ]; then
    ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone
fi


# Custom I3 configuration
if [ -f "/home/sindria/config/i3/config" ]; then
  cp /home/sindria/config/i3/config /home/sindria/.config/i3/config
fi


if [ "${XDEV_MODE}" == "legacy" ]; then
  su ${SINDRIA_USER} -c "export DISPLAY=$DISPLAY && /usr/local/bin/i3"
fi

if [ "${XDEV_MODE}" == "web" ]; then
  #su ${SINDRIA_USER} -c "Xspice --xsession"
  #su ${SINDRIA_USER} -c "/usr/local/bin/i3 ${DISPLAY}"
  su ${SINDRIA_USER} -c "Xspice --port 5900 --disable-ticketing --xsession /usr/local/bin/i3 $DISPLAY  > /dev/null 2>&1 &  /usr/bin/bash"
  websockify -D --web=/usr/share/spice-html5 ${XDEV_WEB_PORT} ${XDEV_SPICE_HOST}:${XDEV_SPICE_PORT} && tail -f /dev/null
fi