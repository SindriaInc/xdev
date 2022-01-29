#!/usr/bin/env bash

# Cleanup lock files
rm -Rf /tmp/i3-sindria.*
rm -f /tmp/X*.lock
rm -Rf /tmp/.X11-unix/X*

# Resetting permission for object storage
if [ -d ${SINDRIA_USER_HOME}/.ssh ]; then
    chmod 700 ${SINDRIA_USER_HOME}/.ssh
    chmod 600 ${SINDRIA_USER_HOME}/.ssh/*
    chmod 644 ${SINDRIA_USER_HOME}/.ssh/*.pub
fi

# Resetting permission for object storage
if [ -d ${SINDRIA_USER_HOME}/.aws ]; then
    chmod 700 ${SINDRIA_USER_HOME}/.aws
    chmod 600 ${SINDRIA_USER_HOME}/.aws/*
fi

# Resetting permission for object storage
if [ -d ${SINDRIA_USER_HOME}/.docker ]; then
    chmod 700 ${SINDRIA_USER_HOME}/.docker
    chmod 600 ${SINDRIA_USER_HOME}/.docker/*
fi


# Setup git username
if [ "${GIT_USERNAME}" != "" ]; then
    su ${SINDRIA_USER} -c "git config --global user.name ${GIT_USERNAME}"
fi

# Setup git email
if [ "${GIT_EMAIL}" != "" ]; then
    su ${SINDRIA_USER} -c "git config --global user.email ${GIT_EMAIL}"
fi

# Setup git editor
if [ "${GIT_EDITOR}" != "" ]; then
    su ${SINDRIA_USER} -c "git config --global core.editor ${GIT_EDITOR}"
fi

# Setup git sindria path
if [ "${GIT_SINDRIA_PATH}" != "" ]; then
    su ${SINDRIA_USER} -c "git config --global sindria.path ${GIT_SINDRIA_PATH}"
fi

# Setup sindria git token
if [ "${GIT_SINDRIA_TOKEN}" != "" ]; then
    su ${SINDRIA_USER} -c "git config --global sindria.token ${GIT_SINDRIA_TOKEN}"
fi

# Setup git sindria url
if [ "${GIT_SINDRIA_URL}" != "" ]; then
    su ${SINDRIA_USER} -c "git config --global sindria.url ${GIT_SINDRIA_URL}"
fi

# Override default sindria user password by env
if [ "${DEFAULT_SINDRIA_USER_PASSWORD}" != "sindria" ]; then
    echo "${SINDRIA_USER}:${DEFAULT_SINDRIA_USER_PASSWORD}" | chpasswd
    vncpasswd -f <<< "${XDEV_SINDRIA_USER_PASSWORD}" > "/root/.vnc/passwd"
    vncpasswd -f <<< "${XDEV_SINDRIA_USER_PASSWORD}" > "${SINDRIA_USER_HOME}/.vnc/passwd"
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
  su ${SINDRIA_USER} -c "/opt/TurboVNC/bin/vncserver -geometry ${XDEV_WEB_RESOLUTION} -xstartup /usr/local/bin/i3 ${DISPLAY}"
  websockify -D --web=/usr/share/novnc/ --cert=~/.novnc/novnc.pem ${XDEV_WEB_PORT} ${XDEV_VNC_HOST}:${XDEV_VNC_PORT} && tail -f /dev/null
fi