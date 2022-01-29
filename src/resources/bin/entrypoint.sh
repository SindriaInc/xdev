#!/usr/bin/env bash

chown root:docker /var/run/docker.sock
chmod 660 /var/run/docker.sock

#
if [ ! -f ${SINDRIA_USER_HOME}/ ]; then
    chmod 700 ${SINDRIA_USER_HOME}/.aws
    chmod 600 ${SINDRIA_USER_HOME}/.aws/*
fi

