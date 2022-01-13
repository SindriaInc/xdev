# Extends xdev wrapper
FROM sindriainc/xdev:wrapper

ARG TAG_VERSION
ARG XDEV_DISPLAY

ENV SINDRIA_USER sindria
ENV SINDRIA_USER_HOME /home/sindria
ENV DISPLAY ${XDEV_DISPLAY}

ENV TELEGRAM_DESKTOP_VERSION 3.4.3
ENV FIREFOX_DEVELOPER_VERSION 97.0b2
ENV WEBSTORM_VERSION 2021.3.1

LABEL \
	name="xdev" \
	image="sindriainc/xdev" \
	tag="${TAG_VERSION}" \
	vendor="sindria"

# Install Git Sindria
RUN cd /tmp && \
    git clone https://github.com/SindriaInc/git-sindria.git && \
    cd git-sindria && \
    make && \
    make install && \
    rm -Rf /tmp/git-sindria

# Install Telegram Desktop
RUN wget https://updates.tdesktop.com/tlinux/tsetup.${TELEGRAM_DESKTOP_VERSION}.tar.xz -P ${SINDRIA_USER_HOME} && \
    tar xvf ${SINDRIA_USER_HOME}/tsetup.${TELEGRAM_DESKTOP_VERSION}.tar.xz -C ${SINDRIA_USER_HOME} && \
    rm -rf ${SINDRIA_USER_HOME}/*.tar.xz && \
    mv ${SINDRIA_USER_HOME}/Telegram ${SINDRIA_USER_HOME}/.Telegram && \
    ln -s ${SINDRIA_USER_HOME}/.Telegram/Telegram /usr/local/bin/telegram-desktop && \
    mkdir -p /var/cache/fontconfig && \
    chown root:${SINDRIA_USER} /var/cache/fontconfig && \
    chmod 775 /var/cache/fontconfig

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

# Install postman
RUN cd /opt && \
    curl -X GET https://dl.pstmn.io/download/latest/linux64 -o postman.tar.gz && \
    tar xzvf postman.tar.gz && \
    rm -rf /opt/*.tar.gz && \
    ln -s /opt/Postman/Postman /usr/local/bin/postman

# Install WebStorm
RUN wget https://download-cf.jetbrains.com/webstorm/WebStorm-${WEBSTORM_VERSION}.tar.gz -P /opt && \
    tar xzf /opt/WebStorm-${WEBSTORM_VERSION}.tar.gz -C /opt && \
    rm -rf /opt/*.tar.gz && \
    mv /opt/WebStorm-* /opt/webstorm && \
    ln -s /opt/webstorm/bin/webstorm.sh /usr/local/bin/webstorm