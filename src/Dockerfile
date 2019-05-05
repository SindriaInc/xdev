# Download base image fedora
FROM fedora:latest

ARG HOST_USER_UID
ARG XDEV_FEDORA_WORKING_DIR

#ENV DEBIAN_FRONTEND noninteractive
ENV SINDRIA_USER sindria
ENV SINDRIA_USER_HOME /home/sindria
ENV SUDO_GROUP wheel
ENV DISPLAY ${XDEV_FEDORA_DISPLAY}

RUN dnf update -y

# Adding sindria user user
RUN useradd ${SINDRIA_USER} -u ${HOST_USER_UID} -m -d ${SINDRIA_USER_HOME} -s /bin/bash
RUN groupmod ${SINDRIA_USER} -g ${HOST_USER_UID}

#COPY .bash_aliases /root/.bash_aliases
#RUN cp /root/.bashrc ${SINDRIA_USER_HOME}/.bashrc
#RUN cp /root/.bash_aliases ${SINDRIA_USER_HOME}/.bash_aliases

# Install base software
RUN dnf install curl vim unzip supervisor git sudo -y

# User permission
RUN chown -R ${SINDRIA_USER}:${SINDRIA_USER} ${SINDRIA_USER_HOME}
RUN usermod -a -G ${SUDO_GROUP} ${SINDRIA_USER}

# Install software
RUN dnf install i3 feh scrot firefox alsa-utils -y

# Supervisor configuration
#COPY supervisor/*.conf /etc/supervisor/conf.d/

# Setting up volume
RUN mkdir -p ${XDEV_FEDORA_WORKING_DIR}
RUN chown -R ${SINDRIA_USER}:${SINDRIA_USER} ${XDEV_FEDORA_WORKING_DIR}
VOLUME ${XDEV_FEDORA_WORKING_DIR}

# Add and execute startup command
#COPY ./startup.sh /startup.sh
#CMD ["/bin/bash", "/startup.sh"]

#EXPOSE 80
