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


if [ ! -d ${HOME}/${XDEV_NAME} ]; then
    echo -e "${BLUE}Xdev name not found, creating...${NC}"
    mkdir -p ${HOME}/${XDEV_NAME}
    mkdir -p ${HOME}/${XDEV_NAME}/storage
    mkdir -p ${HOME}/${XDEV_NAME}/storage/data
    mkdir -p ${HOME}/${XDEV_NAME}/storage/cache
    mkdir -p ${HOME}/${XDEV_NAME}/storage/logs
    mkdir -p ${HOME}/${XDEV_NAME}/storage/secrets
    mkdir -p ${HOME}/${XDEV_NAME}/storage/Projects
fi
echo


MOUNTPOINTS=$(df -h | grep ${XDEV_NAME} |  tr -s ' ' | cut -d ' ' -f 6)
CACHE_MOUNTPOINT=$(df -h | grep ${XDEV_NAME} |  tr -s ' ' | cut -d ' ' -f 6 | grep cache)


if [ "${CACHE_MOUNTPOINT}" != "" ]; then
    echo -e "${BLUE}Found cache mountpoint, symblinking...${NC}"
    touch ${HOME}/${XDEV_NAME}/.cloud
    cd ${HOME}/${XDEV_NAME}
    ln -s storage/cache/deployment/compose-wsl.yml docker-compose.yml || true
    ln -s storage/cache/deployment/.env.wsl .env || true
    cd ${HOME}
fi
echo

if [ ! -f ${HOME}/${XDEV_NAME}/.cloud ]; then
    echo -e "${BLUE}Not found cloud setup, downloading...${NC}"
    cd ${HOME}/${XDEV_NAME}
    wget --no-check-certificate https://raw.githubusercontent.com/SindriaInc/xdev/master/deployments/compose-wsl.yml
    wget --no-check-certificate https://raw.githubusercontent.com/SindriaInc/xdev/master/deployments/.env.wsl
    mv compose-wsl.yml docker-compose.yml
    mv .env.wsl .env
fi
echo

echo -e "${BLUE}Done${NC}"