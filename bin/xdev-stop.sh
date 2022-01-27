#!/usr/bin/env bash

set -e

# Setting Colors
BLUE='\033[0;34m'
YELLOW='\033[0;33m'
RED='\033[0;31m'
NC='\033[0m' #No Color
NOW=$(date "+%Y-%m-%d_%H-%M-%S")

if [[ -z "$1" ]]; then
    echo -e "${YELLOW}Provide Xdev environment name as first argument${NC}"
    exit 1
fi

XDEV_NAME=$1

echo -e "${BLUE}Purging current X11 sockets...${NC}"
docker exec -t ${XDEV_NAME} rm -Rf /tmp/.X1-lock
docker exec -t ${XDEV_NAME} rm -Rf /tmp/.X11-unix
echo

echo -e "${BLUE}Stopping Xdev...${NC}"
cd ${HOME}/${XDEV_NAME} || exit
docker-compose stop
cd ${HOME}
echo

echo -e "${BLUE}Unmounting filesystems...${NC}"
sudo umount ${HOME}/${XDEV_NAME}/storage/data
sudo umount ${HOME}/${XDEV_NAME}/storage/cache
sudo umount ${HOME}/${XDEV_NAME}/storage/logs
sudo umount ${HOME}/${XDEV_NAME}/storage/secrets
echo

echo -e "${BLUE}Purging empty volumes data...${NC}"
find ${HOME}/${XDEV_NAME}/storage/data -maxdepth 1 -mindepth 1 -type d -print0 | xargs -0 rmdir || true
find ${HOME}/${XDEV_NAME}/storage/cache -maxdepth 1 -mindepth 1 -type d -print0 | xargs -0 rmdir || true
find ${HOME}/${XDEV_NAME}/storage/logs -maxdepth 1 -mindepth 1 -type d -print0 | xargs -0 rmdir || true
find ${HOME}/${XDEV_NAME}/storage/secrets -maxdepth 1 -mindepth 1 -type d -print0 | xargs -0 rmdir || true
echo

echo -e "${BLUE}Done${NC}"