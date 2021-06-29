# Extends xdev base
FROM sindriainc/xdev:base

ARG TAG_VERSION
ARG HOST_USER_UID
ARG HOST_DOCKER_GROUP_UID
ARG TIMEZONE
ARG XDEV_DISPLAY
ARG XDEV_SINDRIA_USER_PASSWORD

ENV HOST_USER_UID ${HOST_USER_UID}
ENV HOST_DOCKER_GROUP_UID ${HOST_DOCKER_GROUP_UID}
ENV SINDRIA_USER sindria
ENV SINDRIA_USER_HOME /home/sindria
ENV TZ ${TIMEZONE}
ENV SUDO_GROUP wheel
ENV DISPLAY ${XDEV_DISPLAY}
ENV XDEV_SINDRIA_USER_PASSWORD ${XDEV_SINDRIA_USER_PASSWORD}
ENV XDEV_MODE web
ENV XDEV_WEB_PORT 8080
ENV DOCKER_COMPOSE_VERSION 1.29.2

LABEL \
	name="xdev" \
	image="sindriainc/xdev" \
	tag="${TAG_VERSION}" \
	vendor="sindria"

# Install docker and docker-compose
RUN dnf -y install dnf-plugins-core && \
    dnf config-manager --add-repo https://download.docker.com/linux/fedora/docker-ce.repo && \
    dnf install docker-ce docker-ce-cli containerd.io -y && \
    usermod -a -G docker ${SINDRIA_USER} && \
    groupmod -g ${HOST_DOCKER_GROUP_UID} docker && \
    curl -L "https://github.com/docker/compose/releases/download/${DOCKER_COMPOSE_VERSION}/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose && \
    sudo chmod +x /usr/local/bin/docker-compose && \
    dnf clean all

# Install Kubectl
COPY resources/yum.repos.d/kubernetes.repo /etc/yum.repos.d/kubernetes.repo
RUN dnf install -y kubectl && \
    dnf clean all

# Install Xorg, NOVNC and Websocktify
RUN dnf install -y libXv mesa-libGLU xorg-x11-server-Xorg xorg-x11-xauth xorg-x11-xinit xorg-x11-server-utils novnc python3-websockify python3-numpy && \
    dnf clean all && \
    echo "exec i3" > /root/.xinitrc && \
    echo "exec i3" > ${SINDRIA_USER_HOME}/.xinitrc && \
    mkdir -p /root/.novnc && \
    openssl req -x509 -nodes -newkey rsa:2048 -keyout /root/novnc.pem -out /root/.novnc/novnc.pem -days 3650 -subj "/C=US/ST=NY/L=NY/O=NY/OU=NY/CN=NY emailAddress=email@example.com" && \
    mkdir -p ${SINDRIA_USER_HOME}/.novnc && \
    openssl req -x509 -nodes -newkey rsa:2048 -keyout ${SINDRIA_USER_HOME}/.novnc/novnc.pem -out ${SINDRIA_USER_HOME}/novnc.pem -days 3650 -subj "/C=US/ST=NY/L=NY/O=NY/OU=NY/CN=NY emailAddress=email@example.com"

## Install TightVNC Server
#RUN wget https://raw.githubusercontent.com/rpmsphere/x86_64/master/t/tightvnc-server-1.3.10-18.2.x86_64.rpm -P ${SINDRIA_USER_HOME} && \
#    dnf install ${SINDRIA_USER_HOME}/tightvnc-server-1.3.10-18.2.x86_64.rpm -y && \
#    rm -rf ${SINDRIA_USER_HOME}/*.rpm && \
#    dnf clean all

## Install TigerVNC Server
#RUN dnf install tigervnc-server -y && \
#    dnf clean all

# Install i3, utility and fonts
RUN dnf install -y i3 i3status i3lock dmenu feh xbacklight cmatrix lxrandr pcmanfm alsa-utils cowsay tmate asciinema filezilla thunderbird terminator levien-inconsolata-fonts dejavu-*-fonts mesa-libEGL libXScrnSaver && \
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