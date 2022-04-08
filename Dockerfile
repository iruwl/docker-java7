FROM debian:jessie
MAINTAINER iruwl "iruwl.github.io"

ENV DEBIAN_FRONTEND noninteractive

# Exclude some directories to reduce size
RUN echo "path-exclude /usr/share/doc/*\n#\
we need to keep copyright files for legal reasons\n\
path-include /usr/share/doc/*/copyright\n\
path-exclude /usr/share/man/*\n\
path-exclude /usr/share/groff/*\n\
path-exclude /usr/share/info/*\n#\
lintian stuff is small, but really unnecessary\n\
path-exclude /usr/share/lintian/*\n\
path-exclude /usr/share/linda/*" \
>> /etc/dpkg/dpkg.cfg.d/01_nodoc

# Update + install
RUN apt-get update \
    && apt-get install -y --no-install-recommends openjdk-7-jdk \
    && apt-get install -y --no-install-recommends supervisor

RUN mkdir -p /var/log/supervisor
ENV JAVA_HOME /usr/lib/jvm/java-7-openjdk-amd64
ENV JRE_HOME /usr/lib/jvm/java-7-openjdk-amd64/jre

# Cleansing
RUN apt-get clean -y \
    && apt-get autoclean -y \
    && apt-get autoremove -y \
    && rm -rf /usr/share/locale/* \
    && rm -rf /var/cache/debconf/*-old \
    && rm -rf /var/lib/apt/lists/* \
    && rm -rf /usr/share/doc/*
