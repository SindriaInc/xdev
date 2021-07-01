#!/usr/bin/env bash

if [[ -z "$1" ]]; then
    echo "Provide image name as first argument (eg. sindriainc/<repo-slug>)"
    exit 1
fi

if [[ -z "$2" ]]; then
    echo "Provide a tag version as second argument (eg. 1.0.0)"
    exit 1
fi

IMAGE_NAME=$1
TAG_VERSION=$2

HOST_USER_UID=1000
TIMEZONE=Europe/Rome
HOST_DOCKER_GROUP_UID=975
FEDORA_VERSION=34
XDEV_SINDRIA_USER_PASSWORD=sindria

docker build ./src \
    --tag ${IMAGE_NAME}:${TAG_VERSION} \
    --tag ${IMAGE_NAME}:latest \
    --build-arg TAG_VERSION=${TAG_VERSION} \
    --build-arg FEDORA_VERSION=${FEDORA_VERSION} \
    --build-arg HOST_USER_UID=${HOST_USER_UID} \
    --build-arg HOST_DOCKER_GROUP_UID=${HOST_DOCKER_GROUP_UID} \
    --build-arg XDEV_SINDRIA_USER_PASSWORD=${XDEV_SINDRIA_USER_PASSWORD} \
    --build-arg TIMEZONE=${TIMEZONE}