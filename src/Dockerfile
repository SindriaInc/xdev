# Extends xdev base
FROM sindriainc/xdev:base

ARG TAG_VERSION
ARG HOST_USER_UID
ARG TIMEZONE

ENV HOST_USER_UID ${HOST_USER_UID}
ENV SINDRIA_USER sindria
ENV SINDRIA_USER_HOME /home/sindria
ENV TZ ${TIMEZONE}


LABEL \
	name="xdev" \
	image="sindriainc/xdev" \
	tag="${TAG_VERSION}" \
	vendor="sindria"

