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
ENV XDEV_VNC_HOST localhost
ENV XDEV_VNC_PORT 5901

LABEL \
	name="xdev" \
	image="sindriainc/xdev" \
	tag="${TAG_VERSION}" \
	vendor="sindria"

# Install Xorg, NOVNC and Websocktify
RUN dnf install -y libXv mesa-libGLU xorg-x11-server-Xorg xorg-x11-xauth xorg-x11-xinit xorg-x11-server-utils novnc python3-websockify python3-numpy && \
    dnf clean all && \
    echo "exec i3" > /root/.xinitrc && \
    echo "exec i3" > ${SINDRIA_USER_HOME}/.xinitrc && \
    mkdir -p /root/.novnc && \
    openssl req -x509 -nodes -newkey rsa:2048 -keyout /root/novnc.pem -out /root/.novnc/novnc.pem -days 3650 -subj "/C=US/ST=NY/L=NY/O=NY/OU=NY/CN=NY emailAddress=email@example.com" && \
    rm -f /root/novnc.pem && \
    mkdir -p ${SINDRIA_USER_HOME}/.novnc && \
    openssl req -x509 -nodes -newkey rsa:2048 -keyout ${SINDRIA_USER_HOME}/.novnc/novnc.pem -out ${SINDRIA_USER_HOME}/novnc.pem -days 3650 -subj "/C=US/ST=NY/L=NY/O=NY/OU=NY/CN=NY emailAddress=email@example.com" && \
    rm -f ${SINDRIA_USER_HOME}/novnc.pem

# Install TigerVNC Server
RUN dnf install tigervnc-server -y && \
    dnf clean all

# Install cde, utility and fonts
RUN dnf copr enable dcantrel/cde && \
    dnf install cde -y && \
    dnf install -y feh cmatrix lxrandr pcmanfm alsa-utils cowsay tmate asciinema xterm terminator levien-inconsolata-fonts dejavu-*-fonts mesa-libEGL libXScrnSaver && \
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

COPY resources/cde/wallpapers /home/sindria/Pictures/Wallpapers

# Install VirtualGL
COPY resources/yum.repos.d/virtualgl.repo /etc/yum.repos.d/virtualgl.repo
RUN dnf install -y VirtualGL && \
    dnf clean all

# Install TurboVNC
COPY resources/yum.repos.d/turbovnc.repo /etc/yum.repos.d/turbovnc.repo
RUN dnf install -y turbovnc && \
    dnf clean all && \
    mkdir -p /root/.vnc && \
    vncpasswd -f <<< "${XDEV_SINDRIA_USER_PASSWORD}" > "/root/.vnc/passwd" && \
    chmod 600 /root/.vnc/passwd && \
    mkdir -p ${SINDRIA_USER_HOME}/.vnc && \
    vncpasswd -f <<< "${XDEV_SINDRIA_USER_PASSWORD}" > "${SINDRIA_USER_HOME}/.vnc/passwd" && \
    chmod 600 ${SINDRIA_USER_HOME}/.vnc/passwd

# Reset permission
RUN chown -R ${SINDRIA_USER}:${SINDRIA_USER} ${SINDRIA_USER_HOME}

# Add and execute startup command
COPY ./startup.sh /startup.sh
CMD ["/bin/bash", "/startup.sh"]

EXPOSE 8080