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
ENV SINDRIA_USER sindria
ENV SINDRIA_USER_HOME /home/sindria
ENV SUDO_GROUP wheel
ENV DISPLAY ${XDEV_DISPLAY}
ENV TZ ${TIMEZONE}

ENV DOCKER_COMPOSE_VERSION 1.27.4
ENV TELEGRAM_DESKTOP_VERSION 2.4.3
ENV FIREFOX_DEVELOPER_VERSION 83.0b2
ENV MYSQL_WORKBENCH_VERSION 8.0.22-1
ENV PHPSTORM_VERSION 2020.2.3
ENV PYCHARM_VERSION 2020.2.3
ENV IDEA_VERSION 2020.2.3
ENV WEBSTORM_VERSION 2020.2.3
ENV GOLAND_VERSION 2020.2.3
ENV CLION_VERSION 2020.2.4
ENV DATAGRIP_VERSION 2020.2.3

LABEL \
	name="xdev" \
	image="sindriainc/xdev" \
	tag="${TAG_VERSION}" \
	vendor="sindria"

# Update system, install base software and set timezone
RUN dnf update -y && \
    rpm -ivh http://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-32.noarch.rpm && \
    dnf install curl wget tmux vim unzip supervisor git sudo zsh iputils telnet htop net-tools bzip2 -y && \
    ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone && \
    dnf clean all

COPY resources/etc/sudoers /etc/sudoers

# Adding sindria user
RUN useradd ${SINDRIA_USER} -u ${HOST_USER_UID} -m -d ${SINDRIA_USER_HOME} -s /bin/zsh && \
    groupmod ${SINDRIA_USER} -g ${HOST_USER_UID} && \
    mkdir -p ${SINDRIA_USER_HOME}/config && \
    chown -R ${SINDRIA_USER}:${SINDRIA_USER} ${SINDRIA_USER_HOME} && \
    usermod -a -G ${SUDO_GROUP} ${SINDRIA_USER} && \
    echo "${XDEV_SINDRIA_USER_PASSWORD}:${SINDRIA_USER}" | chpasswd && \
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

# Install i3, utility and fonts
RUN dnf install i3 i3lock feh xbacklight cmatrix lxrandr pcmanfm alsa-utils filezilla thunderbird terminator levien-inconsolata-fonts dejavu-*-fonts -y && \
    mkdir -p /home/sindria/.config && \
    mkdir -p /home/sindria/.config/i3 && \
    mkdir -p /home/sindria/Pictures && \
    mkdir -p /home/sindria/Pictures/Screenshots && \
    mkdir -p /home/sindria/Pictures/Wallpapers && \
    su sindria -c "cd /home/sindria && wget --no-check-certificate http://install.ohmyz.sh -O - | sh" && \
    wget https://justgetflux.com/linux/xflux64.tgz -P /usr/local/bin && \
    tar xzf /usr/local/bin/xflux64.tgz -C /usr/local/bin && \
    rm -rf /usr/local/bin/xflux.tgz && \
    dnf clean all

COPY resources/i3/config /home/sindria/.config/i3

# Install Telegram Desktop
RUN wget https://updates.tdesktop.com/tlinux/tsetup.${TELEGRAM_DESKTOP_VERSION}.tar.xz -P /home/sindria/ && \
    tar xvf /home/sindria/tsetup.${TELEGRAM_DESKTOP_VERSION}.tar.xz -C /home/sindria && \
    rm -rf /home/sindria/*.tar.xz && \
    mv /home/sindria/Telegram /home/sindria/.Telegram && \
    ln -s /home/sindria/.Telegram/Telegram /usr/local/bin/telegram-desktop && \
    mkdir -p /var/cache/fontconfig && \
    chown root:${SINDRIA_USER} /var/cache/fontconfig && \
    chmod 775 /var/cache/fontconfig

# Install Discord
RUN dnf update -y && \
    dnf install -y discord && \
    dnf clean all

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

# Install Mysql Workbench
RUN wget https://cdn.mysql.com//Downloads/MySQLGUITools/mysql-workbench-community-${MYSQL_WORKBENCH_VERSION}.fc32.x86_64.rpm -P /home/sindria && \
    dnf install /home/sindria/mysql-workbench-community-${MYSQL_WORKBENCH_VERSION}.fc32.x86_64.rpm -y && \
    rm -rf /home/sindria/*.rpm && \
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