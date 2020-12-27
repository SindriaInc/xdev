#!/bin/bash

# Install dependencies
dnf install -y libxcb-devel xcb-util-keysyms-devel xcb-util-devel xcb-util-wm-devel xcb-util-xrm-devel yajl-devel libXrandr-devel startup-notification-devel libev-devel xcb-util-cursor-devel libXinerama-devel libxkbcommon-devel libxkbcommon-x11-devel pcre-devel pango-devel gcc automake make

# clone the repository
git clone https://www.github.com/Airblader/i3 i3-gaps
cd i3-gaps

# compile & install
mkdir -p build && cd build
meson ..
ninja
meson install

#cd /tmp
#git clone https://www.github.com/Airblader/i3 i3-gaps
#cd i3-gaps
#autoreconf --force --install
#rm -rf build/
#mkdir -p build
#cd build/
#../configure --prefix=/usr --sysconfdir=/etc --disable-sanitizers
#make
#sudo make install
