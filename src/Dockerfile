# Extends xdev wrapper
FROM sindriainc/xdev:wrapper

ARG TAG_VERSION
ARG XDEV_DISPLAY

ENV SINDRIA_USER sindria
ENV SINDRIA_USER_HOME /home/sindria
ENV DISPLAY ${XDEV_DISPLAY}

ENV LENS_VERSION 5.3.3
ENV LENS_BUILD_VERSION 20211223.1
ENV TELEGRAM_DESKTOP_VERSION 3.4.3
ENV FIREFOX_DEVELOPER_VERSION 97.0b2

LABEL \
	name="xdev" \
	image="sindriainc/xdev" \
	tag="${TAG_VERSION}" \
	vendor="sindria"

# Install Lens
COPY resources/scripts/lens.sh /opt/lens/lens.sh
RUN wget https://lens-binaries.s3-eu-west-1.amazonaws.com/ide/Lens-${LENS_VERSION}-latest.${LENS_BUILD_VERSION}.x86_64.rpm -P ${SINDRIA_USER_HOME} && \
    dnf install ${SINDRIA_USER_HOME}/Lens-${LENS_VERSION}-latest.${LENS_BUILD_VERSION}.x86_64.rpm -y && \
    rm -rf ${SINDRIA_USER_HOME}/*.rpm && \
    dnf clean all && \
    chmod +x /opt/lens/lens.sh && \
    ln -s /opt/lens/lens.sh /usr/local/bin/lens-no-sandbox

# Install Remmina
RUN dnf install -y remmina && \
    dnf clean all

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

# Install vscode
RUN rpm --import https://packages.microsoft.com/keys/microsoft.asc && \
    sh -c 'echo -e "[code]\nname=Visual Studio Code\nbaseurl=https://packages.microsoft.com/yumrepos/vscode\nenabled=1\ngpgcheck=1\ngpgkey=https://packages.microsoft.com/keys/microsoft.asc" > /etc/yum.repos.d/vscode.repo' && \
    dnf install -y code && \
    dnf clean all