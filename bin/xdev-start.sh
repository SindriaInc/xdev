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

echo -e "${BLUE}Mounting filesystems...${NC}"
sudo mount -a
echo

echo -e "${BLUE}Starting Xdev...${NC}"
cd ${HOME}/${XDEV_NAME} || exit
docker-compose up -d
cd ${HOME}
echo

echo -e "${BLUE}Done${NC}"