#!/usr/bin/env bash

# Add custom hosts
#if [ ! -f "/home/sindria/config/etc/.done" ]; then
#  cat /home/sindria/config/etc/hosts >> /etc/hosts
#  touch /home/sindria/config/etc/.done
#fi

# Custom I3 configuration
if [ -f "/home/sindria/config/i3/config" ]; then
  cp /home/sindria/config/i3/config /home/sindria/.config/i3/config
fi

su sindria -c "export DISPLAY=$DISPLAY && /usr/bin/i3"