# Extends xdev wrapper
FROM sindriainc/xdev:wrapper

ARG TAG_VERSION
ARG XDEV_DISPLAY

ENV SINDRIA_USER sindria
ENV SINDRIA_USER_HOME /home/sindria
ENV DISPLAY ${XDEV_DISPLAY}

ENV TELEGRAM_DESKTOP_VERSION 3.4.3
ENV FIREFOX_DEVELOPER_VERSION 97.0b2
ENV PHPSTORM_VERSION 2021.3.1
ENV PYCHARM_VERSION 2021.3.1
ENV IDEA_VERSION 2021.3.1
ENV WEBSTORM_VERSION 2021.3.1
ENV RUBYMINE_VERSION 2021.3.1
ENV GOLAND_VERSION 2021.3.1
ENV CLION_VERSION 2021.3.1
ENV DATAGRIP_VERSION 2021.3.1

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

# Install sublime text
RUN rpm -v --import https://download.sublimetext.com/sublimehq-rpm-pub.gpg && \
    dnf config-manager --add-repo https://download.sublimetext.com/rpm/stable/x86_64/sublime-text.repo && \
    dnf install sublime-text -y && \
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