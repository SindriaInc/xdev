# Download base image fedora
ARG FEDORA_VERSION
FROM fedora:${FEDORA_VERSION}

ARG FEDORA_VERSION
ARG TAG_VERSION
ARG HOST_USER_UID
ARG TIMEZONE
ARG XDEV_SINDRIA_USER_PASSWORD

ENV FEDORA_VERSION ${FEDORA_VERSION}
ENV HOST_USER_UID ${HOST_USER_UID}
ENV SINDRIA_USER sindria
ENV SINDRIA_USER_HOME /home/sindria
ENV TZ ${TIMEZONE}
ENV SUDO_GROUP wheel
ENV XDEV_SINDRIA_USER_PASSWORD ${XDEV_SINDRIA_USER_PASSWORD}

LABEL \
	name="xdev" \
	image="sindriainc/xdev" \
	tag="${TAG_VERSION}" \
	vendor="sindria"

# Update system, install base software and set timezone
RUN dnf update -y && \
    rpm -ivh http://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-${FEDORA_VERSION}.noarch.rpm && \
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

# Reset permission
RUN chown -R ${SINDRIA_USER}:${SINDRIA_USER} ${SINDRIA_USER_HOME}

SHELL ["/bin/bash"]