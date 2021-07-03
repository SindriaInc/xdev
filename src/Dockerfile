# Extends xdev base
FROM sindriainc/xdev:base

ARG TAG_VERSION
ARG HOST_USER_UID
ARG TIMEZONE
ARG XDEV_DISPLAY
ARG XDEV_SINDRIA_USER_PASSWORD

ENV HOST_USER_UID ${HOST_USER_UID}
ENV SINDRIA_USER sindria
ENV SINDRIA_USER_HOME /home/sindria
ENV TZ ${TIMEZONE}
ENV SUDO_GROUP wheel
ENV DISPLAY ${XDEV_DISPLAY}
ENV XDEV_SINDRIA_USER_PASSWORD ${XDEV_SINDRIA_USER_PASSWORD}
ENV XDEV_MODE web
ENV XDEV_WEB_PORT 8080
ENV XDEV_WEB_RESOLUTION 1920x1080
ENV XDEV_SPICE_HOST localhost
ENV XDEV_SPICE_PORT 5900

LABEL \
	name="xdev" \
	image="sindriainc/xdev" \
	tag="${TAG_VERSION}" \
	vendor="sindria"

# Install Xorg and Websocktify
RUN dnf install -y libXv mesa-libGLU xorg-x11-server-Xorg xorg-x11-xauth xorg-x11-xinit xorg-x11-server-utils python3-websockify python3-numpy && \
    dnf clean all && \
    echo "exec i3" > /root/.xinitrc && \
    echo "exec i3" > ${SINDRIA_USER_HOME}/.xinitrc

# Install i3, utility and fonts
RUN dnf install -y i3 i3status i3lock dmenu feh xbacklight cmatrix lxrandr pcmanfm alsa-utils cowsay tmate asciinema xterm terminator levien-inconsolata-fonts dejavu-*-fonts mesa-libEGL libXScrnSaver && \
    mkdir -p ${SINDRIA_USER_HOME}/.config && \
    mkdir -p ${SINDRIA_USER_HOME}/.config/i3 && \
    mkdir -p ${SINDRIA_USER_HOME}/Projects && \
    mkdir -p ${SINDRIA_USER_HOME}/Pictures && \
    mkdir -p ${SINDRIA_USER_HOME}/Pictures/Screenshots && \
    mkdir -p ${SINDRIA_USER_HOME}/Pictures/Wallpapers && \
    su sindria -c "cd ${SINDRIA_USER_HOME} && wget --no-check-certificate http://install.ohmyz.sh -O - | sh" && \
    wget https://justgetflux.com/linux/xflux64.tgz -P /usr/local/bin && \
    tar xzf /usr/local/bin/xflux64.tgz -C /usr/local/bin && \
    rm -rf /usr/local/bin/xflux.tgz && \
    dnf clean all

# Install i3-gaps from source
RUN dnf install -y libxcb-devel xcb-util-keysyms-devel xcb-util-devel xcb-util-wm-devel xcb-util-xrm-devel yajl-devel libXrandr-devel startup-notification-devel libev-devel xcb-util-cursor-devel libXinerama-devel libxkbcommon-devel libxkbcommon-x11-devel pcre-devel pango-devel git gcc automake && \
    dnf install -y python3-pip ninja-build perl-devel && \
    pip install meson && \
    cd /tmp && \
    git clone https://www.github.com/Airblader/i3 i3-gaps && \
    cd i3-gaps && \
    mkdir -p build && cd build && \
    meson .. && \
    ninja && \
    meson install && \
    rm -Rf /tmp/i3-gaps

COPY resources/i3/config /home/sindria/.config/i3
COPY resources/i3/wallpapers /home/sindria/Pictures/Wallpapers

# Install VirtualGL
COPY resources/yum.repos.d/virtualgl.repo /etc/yum.repos.d/virtualgl.repo
RUN dnf install -y VirtualGL && \
    dnf clean all

# Install Spice


# Reset permission
RUN chown -R ${SINDRIA_USER}:${SINDRIA_USER} ${SINDRIA_USER_HOME}

# Add and execute startup command
COPY ./startup.sh /startup.sh
CMD ["/bin/bash", "/startup.sh"]

EXPOSE 8080