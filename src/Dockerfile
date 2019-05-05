# Download base image fedora
FROM fedora:latest

ARG HOST_USER_UID
ARG XDEV_PHP_WORKING_DIR
ARG XDEV_PHP_DISPLAY
ARG SINDRIA_USER_PASSWORD

ENV SINDRIA_USER sindria
ENV SINDRIA_USER_HOME /home/sindria
ENV SUDO_GROUP wheel
ENV DISPLAY ${XDEV_PHP_DISPLAY}

# Update system
RUN dnf update -y

# Adding sindria user user
RUN useradd ${SINDRIA_USER} -u ${HOST_USER_UID} -m -d ${SINDRIA_USER_HOME} -s /bin/bash
RUN groupmod ${SINDRIA_USER} -g ${HOST_USER_UID}

#COPY .bash_aliases /root/.bash_aliases
#RUN cp /root/.bashrc ${SINDRIA_USER_HOME}/.bashrc
#RUN cp /root/.bash_aliases ${SINDRIA_USER_HOME}/.bash_aliases

# Install base software
RUN dnf install curl wget tmux vim unzip supervisor git sudo zsh iputils htop net-tools bzip2 -y

# User permission
RUN chown -R ${SINDRIA_USER}:${SINDRIA_USER} ${SINDRIA_USER_HOME}
RUN usermod -a -G ${SUDO_GROUP} ${SINDRIA_USER}
RUN echo "${SINDRIA_USER_PASSWORD}:${SINDRIA_USER}" | chpasswd
RUN chmod 644 /etc/sudoers
RUN sed -i -e -r "s|#%wheel  ALL=(ALL)       NOPASSWD: ALL|%wheel  ALL=(ALL)       NOPASSWD: ALL|g" /etc/sudoers

# Install docker client
RUN dnf -y install dnf-plugins-core
RUN dnf config-manager --add-repo https://download.docker.com/linux/fedora/docker-ce.repo
RUN dnf install docker-ce docker-ce-cli containerd.io -y
RUN usermod -a -G docker ${SINDRIA_USER}

# Install i3, utility and fonts
RUN dnf install i3 i3lock feh scrot xbacklight cmatrix lxrandr pcmanfm alsa-utils filezilla terminator levien-inconsolata-fonts dejavu-*-fonts -y

# I3 configuration
RUN mkdir -p /home/sindria/.config
RUN mkdir -p /home/sindria/.config/i3
COPY ./i3/config /home/sindria/.config/i3
RUN mkdir -p /home/sindria/Pictures
RUN mkdir -p /home/sindria/Pictures/Screenshots
RUN mkdir -p /home/sindria/Pictures/Wallpapers

# Install Telegram Desktop
RUN wget https://updates.tdesktop.com/tlinux/tsetup.1.6.7.tar.xz -P /home/sindria/
RUN tar xvf /home/sindria/tsetup.1.6.7.tar.xz -C /home/sindria
RUN rm -rf /home/sindria/tsetup.1.6.7.tar.xz
RUN mv /home/sindria/Telegram /home/sindria/.Telegram
RUN ln -s /home/sindria/.Telegram/Telegram /usr/local/bin/telegram-desktop
RUN mkdir -p /var/cache/fontconfig 
RUN chown root:${SINDRIA_USER} /var/cache/fontconfig
RUN chmod 775 /var/cache/fontconfig

# Install firefox developer edition
RUN wget https://download-installer.cdn.mozilla.net/pub/devedition/releases/67.0b16/linux-x86_64/en-US/firefox-67.0b16.tar.bz2 -P /opt
RUN bzip2 -d /opt/firefox-67.0b16.tar.bz2
RUN tar xf /opt/firefox-67.0b16.tar -C /opt
RUN rm -rf /opt/*.bz2
RUN rm -rf /opt/*.tar
RUN mv /opt/firefox /opt/firefox-developer
RUN ln -s /opt/firefox-developer/firefox /usr/local/bin/firefox-developer

# Install xflux
RUN wget https://justgetflux.com/linux/xflux64.tgz -P /usr/local/bin
RUN tar xzf /usr/local/bin/xflux64.tgz -C /usr/local/bin
RUN rm -rf /usr/local/bin/xflux.tgz

# Install sublime text
RUN rpm -v --import https://download.sublimetext.com/sublimehq-rpm-pub.gpg
RUN dnf config-manager --add-repo https://download.sublimetext.com/rpm/stable/x86_64/sublime-text.repo 
RUN dnf install sublime-text -y

# Install PhpStorm
RUN wget https://download-cf.jetbrains.com/webide/PhpStorm-2019.1.1.tar.gz -P /opt
RUN tar xzf /opt/PhpStorm-2019.1.1.tar.gz -C /opt
RUN rm -rf /opt/PhpStorm-2019.1.1.tar.gz
RUN mv /opt/PhpStorm-* /opt/PhpStorm
RUN ln -s /opt/PhpStorm/bin/phpstorm.sh /usr/local/bin/phpstorm

# Install Mysql Workbench
RUN wget https://cdn.mysql.com//Downloads/MySQLGUITools/mysql-workbench-community-8.0.16-1.fc29.x86_64.rpm -P /home/sindria
RUN dnf install /home/sindria/mysql-workbench-community-8.0.16-1.fc29.x86_64.rpm -y
RUN rm -rf /home/sindria/mysql-workbench-community-8.0.16-1.fc29.x86_64.rpm

# Install oh-my-zsh
RUN su sindria -c "cd /home/sindria && wget --no-check-certificate http://install.ohmyz.sh -O - | sh"
RUN usermod -s /bin/zsh ${SINDRIA_USER}

# Setting up volume
RUN mkdir -p ${XDEV_PHP_WORKING_DIR}
RUN chown -R ${SINDRIA_USER}:${SINDRIA_USER} ${XDEV_PHP_WORKING_DIR}
VOLUME ${XDEV_PHP_WORKING_DIR}

# Reset permission
RUN chown -R ${SINDRIA_USER}:${SINDRIA_USER} ${SINDRIA_USER_HOME}

# Add and execute startup command
#COPY ./startup.sh /startup.sh
#CMD ["/bin/bash", "/startup.sh"]

#EXPOSE 80
