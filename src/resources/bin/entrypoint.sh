#!/usr/bin/env bash

chown root:docker /var/run/docker.sock
chmod 660 /var/run/docker.sock