#!/usr/bin/env bash

# Cleanup lock files
rm -Rf /tmp/i3-sindria.*
rm -f /tmp/X*.lock
rm -Rf /tmp/.X11-unix/X*

# Override default sindria user password by env
if [ "$DEFAULT_SINDRIA_USER_PASSWORD" != "sindria" ]; then
    echo "sindria:${DEFAULT_SINDRIA_USER_PASSWORD}" | chpasswd
    vncpasswd -f <<< "${XDEV_SINDRIA_USER_PASSWORD}" > "/root/.vnc/passwd"
    vncpasswd -f <<< "${XDEV_SINDRIA_USER_PASSWORD}" > "${SINDRIA_USER_HOME}/.vnc/passwd"
fi


# Override host user uid by env
if [ "$HOST_USER_UID" != "1000" ]; then
    usermod -u $HOST_USER_UID sindria && groupmod sindria -g $HOST_USER_UID
fi


# Override docker host uid by env
if [ "$HOST_DOCKER_GROUP_UID" != "975" ]; then
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


if [ "${XDEV_MODE}" == "legacy" ]; then
  su sindria -c "export DISPLAY=$DISPLAY && /usr/local/bin/i3"
fi

if [ "${XDEV_MODE}" == "web" ]; then
  su sindria -c "/opt/TurboVNC/bin/vncserver -geometry 1920x1080 -xstartup /usr/local/bin/i3" 
  websockify -D --web=/usr/share/novnc/ --cert=~/.novnc/novnc.pem ${XDEV_WEB_PORT} localhost:5901 && tail -f /dev/null
fi
