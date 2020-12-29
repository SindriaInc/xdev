# Download base image fedora
ARG FEDORA_VERSION
FROM fedora:${FEDORA_VERSION}

ARG TAG_VERSION
ARG HOST_USER_UID
ARG HOST_DOCKER_GROUP_UID
ARG TIMEZONE
ARG XDEV_DISPLAY
ARG XDEV_SINDRIA_USER_PASSWORD

ENV FEDORA_VERSION ${FEDORA_VERSION}
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

ENV DOCKER_COMPOSE_VERSION 1.27.4
ENV GIT_SINDRIA_VERSION 1.1.0-1
ENV TELEGRAM_DESKTOP_VERSION 2.5.1
ENV DISCORD_VERSION 0.0.12-1 
ENV FIREFOX_DEVELOPER_VERSION 85.0b4
ENV MYSQL_WORKBENCH_VERSION 8.0.22-1
ENV PHPSTORM_VERSION 2020.3
ENV PYCHARM_VERSION 2020.3.1
ENV IDEA_VERSION 2020.3
ENV WEBSTORM_VERSION 2020.3
ENV RUBYMINE_VERSION 2020.3
ENV GOLAND_VERSION 2020.3
ENV CLION_VERSION 2020.3
ENV DATAGRIP_VERSION 2020.3.1

LABEL \
	name="xdev" \
	image="sindriainc/xdev" \
	tag="${TAG_VERSION}" \
	vendor="sindria"

# Update system, install base software and set timezone
RUN dnf update -y && \
    rpm -ivh http://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-32.noarch.rpm && \
    dnf install curl wget tmux screen rsync vim unzip supervisor git sudo zsh passwd procps iputils telnet htop net-tools hostname openvpn bzip2 -y && \
    ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone && \
    dnf clean all

COPY resources/etc/sudoers /etc/sudoers

# Adding sindria user
RUN useradd ${SINDRIA_USER} -u ${HOST_USER_UID} -m -d ${SINDRIA_USER_HOME} -s /bin/zsh && \
    groupmod ${SINDRIA_USER} -g ${HOST_USER_UID} && \
    mkdir -p ${SINDRIA_USER_HOME}/config && \
    chown -R ${SINDRIA_USER}:${SINDRIA_USER} ${SINDRIA_USER_HOME} && \
    usermod -a -G ${SUDO_GROUP} ${SINDRIA_USER} && \
    echo "${SINDRIA_USER}:${XDEV_SINDRIA_USER_PASSWORD}" | chpasswd && \
    chmod 644 /etc/sudoers

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

# Install TightVNC Server
RUN wget https://raw.githubusercontent.com/rpmsphere/x86_64/master/t/tightvnc-server-1.3.10-18.2.x86_64.rpm -P ${SINDRIA_USER_HOME} && \
    dnf install ${SINDRIA_USER_HOME}/tightvnc-server-1.3.10-18.2.x86_64.rpm -y && \
    rm -rf ${SINDRIA_USER_HOME}/*.rpm && \
    dnf clean all

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

# Install pandoc
#RUN dnf install -y texlive-scheme-full pandoc && \
#    dnf clean all

# Install Git Sindria
RUN wget https://raw.githubusercontent.com/SindriaInc/git-sindria/master/rpms/git-sindria-${GIT_SINDRIA_VERSION}.noarch.rpm -P ${SINDRIA_USER_HOME} && \
    dnf install -y ${SINDRIA_USER_HOME}/git-sindria-${GIT_SINDRIA_VERSION}.noarch.rpm && \
    rm -rf ${SINDRIA_USER_HOME}/*.rpm && \
    dnf clean all

# Install Telegram Desktop
RUN wget https://updates.tdesktop.com/tlinux/tsetup.${TELEGRAM_DESKTOP_VERSION}.tar.xz -P ${SINDRIA_USER_HOME} && \
    tar xvf ${SINDRIA_USER_HOME}/tsetup.${TELEGRAM_DESKTOP_VERSION}.tar.xz -C ${SINDRIA_USER_HOME} && \
    rm -rf ${SINDRIA_USER_HOME}/*.tar.xz && \
    mv ${SINDRIA_USER_HOME}/Telegram ${SINDRIA_USER_HOME}/.Telegram && \
    ln -s ${SINDRIA_USER_HOME}/.Telegram/Telegram /usr/local/bin/telegram-desktop && \
    mkdir -p /var/cache/fontconfig && \
    chown root:${SINDRIA_USER} /var/cache/fontconfig && \
    chmod 775 /var/cache/fontconfig

# Install Discord
#RUN dnf update -y && \
#    wget https://download1.rpmfusion.org/nonfree/fedora/updates/32/x86_64/d/discord-${DISCORD_VERSION}.fc32.x86_64.rpm -P ${SINDRIA_USER_HOME} && \
#    dnf install ${SINDRIA_USER_HOME}/discord-${DISCORD_VERSION}.fc32.x86_64.rpm -y && \
#    rm -rf ${SINDRIA_USER_HOME}/*.rpm && \
#    dnf clean all

# Install Google-Chrome
COPY resources/scripts/chrome.sh /opt/chrome/chrome.sh
RUN wget https://dl.google.com/linux/direct/google-chrome-stable_current_x86_64.rpm -P ${SINDRIA_USER_HOME} && \
    dnf install ${SINDRIA_USER_HOME}/google-chrome-stable_current_x86_64.rpm -y && \
    rm -rf ${SINDRIA_USER_HOME}/*.rpm && \
    dnf clean all && \
    chmod +x /opt/chrome/chrome.sh && \
    ln -s /opt/chrome/chrome.sh /usr/local/bin/chrome

# Install firefox developer edition
RUN wget https://download-installer.cdn.mozilla.net/pub/devedition/releases/${FIREFOX_DEVELOPER_VERSION}/linux-x86_64/en-US/firefox-${FIREFOX_DEVELOPER_VERSION}.tar.bz2 -P /opt && \
    bzip2 -d /opt/firefox-${FIREFOX_DEVELOPER_VERSION}.tar.bz2 && \
    tar xf /opt/firefox-${FIREFOX_DEVELOPER_VERSION}.tar -C /opt && \
    rm -rf /opt/*.bz2 && \
    rm -rf /opt/*.tar && \
    mv /opt/firefox /opt/firefox-developer && \
    ln -s /opt/firefox-developer/firefox /usr/local/bin/firefox-developer

# Install sublime text
RUN rpm -v --import https://download.sublimetext.com/sublimehq-rpm-pub.gpg && \
    dnf config-manager --add-repo https://download.sublimetext.com/rpm/stable/x86_64/sublime-text.repo && \
    dnf install sublime-text -y && \
    dnf clean all

# Install vscode
RUN rpm --import https://packages.microsoft.com/keys/microsoft.asc && \
    sh -c 'echo -e "[code]\nname=Visual Studio Code\nbaseurl=https://packages.microsoft.com/yumrepos/vscode\nenabled=1\ngpgcheck=1\ngpgkey=https://packages.microsoft.com/keys/microsoft.asc" > /etc/yum.repos.d/vscode.repo' && \
    dnf install -y code && \
    dnf clean all

# Install Mysql Workbench
RUN wget https://cdn.mysql.com//Downloads/MySQLGUITools/mysql-workbench-community-${MYSQL_WORKBENCH_VERSION}.fc32.x86_64.rpm -P ${SINDRIA_USER_HOME} && \
    dnf install ${SINDRIA_USER_HOME}/mysql-workbench-community-${MYSQL_WORKBENCH_VERSION}.fc32.x86_64.rpm -y && \
    rm -rf ${SINDRIA_USER_HOME}/*.rpm && \
    dnf clean all

# Install PhpStorm
RUN wget https://download-cf.jetbrains.com/webide/PhpStorm-${PHPSTORM_VERSION}.tar.gz -P /opt && \
    tar xzf /opt/PhpStorm-${PHPSTORM_VERSION}.tar.gz -C /opt && \
    rm -rf /opt/*.tar.gz && \
    mv /opt/PhpStorm-* /opt/phpstorm && \
    ln -s /opt/phpstorm/bin/phpstorm.sh /usr/local/bin/phpstorm

# Install PyCharm
RUN wget https://download-cf.jetbrains.com/python/pycharm-professional-${PYCHARM_VERSION}.tar.gz -P /opt && \
    tar xzf /opt/pycharm-professional-${PYCHARM_VERSION}.tar.gz -C /opt && \
    rm -rf /opt/*.tar.gz && \
    mv /opt/pycharm-* /opt/pycharm && \
    ln -s /opt/pycharm/bin/pycharm.sh /usr/local/bin/pycharm

# Install Idea
RUN wget https://download-cf.jetbrains.com/idea/ideaIU-${IDEA_VERSION}.tar.gz -P /opt && \
    tar xzf /opt/ideaIU-${IDEA_VERSION}.tar.gz -C /opt && \
    rm -rf /opt/*.tar.gz && \
    mv /opt/idea-* /opt/idea && \
    ln -s /opt/idea/bin/idea.sh /usr/local/bin/idea

# Install WebStorm
RUN wget https://download-cf.jetbrains.com/webstorm/WebStorm-${WEBSTORM_VERSION}.tar.gz -P /opt && \
    tar xzf /opt/WebStorm-${WEBSTORM_VERSION}.tar.gz -C /opt && \
    rm -rf /opt/*.tar.gz && \
    mv /opt/WebStorm-* /opt/webstorm && \
    ln -s /opt/webstorm/bin/webstorm.sh /usr/local/bin/webstorm

# Install RubyMine
RUN wget https://download-cf.jetbrains.com/ruby/RubyMine-${RUBYMINE_VERSION}.tar.gz -P /opt && \
    tar xzf /opt/RubyMine-${RUBYMINE_VERSION}.tar.gz -C /opt && \
    rm -rf /opt/*.tar.gz && \
    mv /opt/RubyMine-* /opt/rubymine && \
    ln -s /opt/rubymine/bin/rubymine.sh /usr/local/bin/rubymine

# Install Goland
RUN wget https://download-cf.jetbrains.com/go/goland-${GOLAND_VERSION}.tar.gz -P /opt && \
    tar xzf /opt/goland-${GOLAND_VERSION}.tar.gz -C /opt && \
    rm -rf /opt/*.tar.gz && \
    mv /opt/GoLand-* /opt/goland && \
    ln -s /opt/goland/bin/goland.sh /usr/local/bin/goland

# Install CLion
RUN wget https://download-cf.jetbrains.com/cpp/CLion-${CLION_VERSION}.tar.gz -P /opt && \
    tar xzf /opt/CLion-${CLION_VERSION}.tar.gz -C /opt && \
    rm -rf /opt/*.tar.gz && \
    mv /opt/clion-* /opt/clion && \
    ln -s /opt/clion/bin/clion.sh /usr/local/bin/clion

# Install DataGrip
RUN wget https://download-cf.jetbrains.com/datagrip/datagrip-${DATAGRIP_VERSION}.tar.gz -P /opt && \
    tar xzf /opt/datagrip-${DATAGRIP_VERSION}.tar.gz -C /opt && \
    rm -rf /opt/*.tar.gz && \
    mv /opt/DataGrip-* /opt/datagrip && \
    ln -s /opt/datagrip/bin/datagrip.sh /usr/local/bin/datagrip

# Reset permission
RUN chown -R ${SINDRIA_USER}:${SINDRIA_USER} ${SINDRIA_USER_HOME}

# Add and execute startup command
COPY ./startup.sh /startup.sh
CMD ["/bin/bash", "/startup.sh"]

EXPOSE 8080
