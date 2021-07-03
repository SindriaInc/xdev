# Extends xdev wrapper
FROM sindriainc/xdev:wrapper

ARG TAG_VERSION
ARG XDEV_DISPLAY

ENV SINDRIA_USER sindria
ENV SINDRIA_USER_HOME /home/sindria
ENV DISPLAY ${XDEV_DISPLAY}
ENV PHPSTORM_VERSION 2021.1.4

LABEL \
	name="xdev" \
	image="sindriainc/xdev" \
	tag="${TAG_VERSION}" \
	vendor="sindria"

# Install PhpStorm
RUN wget https://download-cf.jetbrains.com/webide/PhpStorm-${PHPSTORM_VERSION}.tar.gz -P /opt && \
    tar xzf /opt/PhpStorm-${PHPSTORM_VERSION}.tar.gz -C /opt && \
    rm -rf /opt/*.tar.gz && \
    mv /opt/PhpStorm-* /opt/phpstorm && \
    ln -s /opt/phpstorm/bin/phpstorm.sh /usr/local/bin/phpstorm && \
    echo -n "#PhpStorm\nexec --no-startup-id phpstorm" >> ${SINDRIA_USER_HOME}/.config/i3/config