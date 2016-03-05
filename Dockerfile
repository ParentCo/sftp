FROM debian:jessie
MAINTAINER Adrian Dvergsdal [atmoz.net]

RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get -y install openssh-server && \
    rm -rf /var/lib/apt/lists/*

RUN apt-get update && \
    apt-get install -y apt-utils glusterfs-client dnsutils

ENV GLUSTER_VOL ranchervol
ENV GLUSTER_VOL_PATH /var/www
ENV GLUSTER_HOST storage
ENV DEBUG 0

RUN mkdir -p ${GLUSTER_VOL_PATH}

# sshd needs this directory to run
RUN mkdir -p /var/run/sshd

COPY sshd_config /etc/ssh/sshd_config
COPY entrypoint /
COPY README.md /

EXPOSE 22

ENTRYPOINT ["/entrypoint"]
