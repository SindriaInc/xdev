# Download base image fedora
ARG FEDORA_VERSION
FROM fedora:${FEDORA_VERSION}

ARG TAG_VERSION
ARG HOST_USER_UID
ARG HOST_DOCKER_GROUP_UID
ARG XDEV_DISPLAY
ARG XDEV_SINDRIA_USER_PASSWORD

ENV HOST_USER_UID ${HOST_USER_UID}
ENV HOST_DOCKER_GROUP_UID ${HOST_DOCKER_GROUP_UID}
ENV SINDRIA_USER sindria
ENV SINDRIA_USER_HOME /home/sindria
ENV DISPLAY ${XDEV_DISPLAY}
ENV XDEV_SINDRIA_USER_PASSWORD ${XDEV_SINDRIA_USER_PASSWORD}

ENV DOCKER_COMPOSE_VERSION 1.27.4
ENV GIT_SINDRIA_VERSION 1.1.0-1
ENV PHPSTORM_VERSION 2020.3


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

# Install PhpStorm
RUN wget https://download-cf.jetbrains.com/webide/PhpStorm-${PHPSTORM_VERSION}.tar.gz -P /opt && \
    tar xzf /opt/PhpStorm-${PHPSTORM_VERSION}.tar.gz -C /opt && \
    rm -rf /opt/*.tar.gz && \
    mv /opt/PhpStorm-* /opt/phpstorm && \
    ln -s /opt/phpstorm/bin/phpstorm.sh /usr/local/bin/phpstorm

# Reset permission
RUN chown -R ${SINDRIA_USER}:${SINDRIA_USER} ${SINDRIA_USER_HOME}

# Add and execute startup command
COPY ./startup.sh /startup.sh
CMD ["/bin/bash", "/startup.sh"]