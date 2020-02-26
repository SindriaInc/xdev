#!/usr/bin/env bash

if [[ -z "$1" ]]; then
    echo "Provide user UID"
    exit 1
fi

if [[ -z "$2" ]]; then
    echo "Provide a tag version as second argument (eg. 1.0.0)"
    exit 1
fi

IMAGE_NAME="sindriainc/xdev"

HOST_USER_UID=$1
TAG_VERSION=$2

TIMEZONE=Europe/Rome
FEDORA_VERSION=31
HOST_DOCKER_GROUP_UID=975
XDEV_SINDRIA_USER_PASSWORD=sindria
XDEV_DISPLAY=:0.0

docker build ./src \
    --tag ${IMAGE_NAME}:${TAG_VERSION} \
    --tag ${IMAGE_NAME}:latest \
    --build-arg TAG_VERSION=${TAG_VERSION} \
    --build-arg FEDORA_VERSION=${FEDORA_VERSION} \
    --build-arg HOST_USER_UID=${HOST_USER_UID} \
    --build-arg HOST_DOCKER_GROUP_UID=${HOST_DOCKER_GROUP_UID} \
    --build-arg XDEV_SINDRIA_USER_PASSWORD=${XDEV_SINDRIA_USER_PASSWORD} \
    --build-arg XDEV_DISPLAY=${XDEV_DISPLAY} \
    --build-arg TIMEZONE=${TIMEZONE}