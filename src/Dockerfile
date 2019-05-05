# Download base image fedora
FROM fedora:latest

ARG HOST_USER_UID
ARG XDEV_PHP_WORKING_DIR
ARG XDEV_PHP_DISPLAY

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
RUN dnf install curl wget tmux vim unzip supervisor git sudo zsh iputils net-tools -y

# User permission
RUN chown -R ${SINDRIA_USER}:${SINDRIA_USER} ${SINDRIA_USER_HOME}
RUN usermod -a -G ${SUDO_GROUP} ${SINDRIA_USER}

# Install docker client
RUN dnf -y install dnf-plugins-core
RUN dnf config-manager --add-repo https://download.docker.com/linux/fedora/docker-ce.repo
RUN dnf install docker-ce docker-ce-cli containerd.io -y

# Install i3, utility and fonts
RUN dnf install i3 i3lock feh scrot xbacklight cmatrix lxrandr pcmanfm alsa-utils filezilla terminator levien-inconsolata-fonts dejavu-*-fonts -y

# Install firefox developer edition

# Install xflux
RUN wget https://justgetflux.com/linux/xflux64.tgz -O /usr/local/bin
RUN tar xzf /usr/local/bin/xflux64.tgz
RUN rm -rf /usr/local/bin/xflux.tgz

# Install sublime text
RUN rpm -v --import https://download.sublimetext.com/sublimehq-rpm-pub.gpg
RUN dnf config-manager --add-repo https://download.sublimetext.com/rpm/stable/x86_64/sublime-text.repo 
RUN dnf install sublime-text -y

# Install PhpStorm
RUN wget https://download-cf.jetbrains.com/webide/PhpStorm-2019.1.1.tar.gz -O /opt
RUN tar xzf /opt/PhpStorm-2019.1.1.tar.gz
RUN rm -rf /opt/PhpStorm-2019.1.1.tar.gz
RUN mv /opt/PhpStorm-* /opt/PhpStorm
RUN ln -s /opt/PhpStorm/bin/phpstorm.sh /usr/local/bin/phpstorm

# Install oh-my-zsh
RUN su sindria -c "cd /home/sindria && wget --no-check-certificate http://install.ohmyz.sh -O - | sh"

# Setting up volume
RUN mkdir -p ${XDEV_PHP_WORKING_DIR}
RUN chown -R ${SINDRIA_USER}:${SINDRIA_USER} ${XDEV_PHP_WORKING_DIR}
VOLUME ${XDEV_PHP_WORKING_DIR}

# Add and execute startup command
#COPY ./startup.sh /startup.sh
#CMD ["/bin/bash", "/startup.sh"]

#EXPOSE 80
