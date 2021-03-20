FROM ubuntu:20.04
RUN mkdir -p /kaniko/.docker
# From 2 will grab the files we need from the kaniko image. This only works when this dockerfile has been appended to
# the actual debug dockerfile in the kaniko repo.
COPY --from=2 /kaniko/executor /usr/local/bin/kaniko
COPY files/nsswitch.conf /etc/nsswitch.conf
ENV HOME /root
ENV USER root
ENV PATH /usr/local/bin:/bin:$PATH
ENV DOCKER_CONFIG /kaniko/.docker/

# Now that we have all the kaniko files we need, install the additional tools we want to use.
ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get update && apt-get install -y \
    curl \
    gnupg2 \
    lsb-release \
    software-properties-common \
    git \
    build-essential

LABEL org.opencontainers.image.url=https://github.com/harderthanitneedstobe/kaniko-ci
LABEL org.opencontainers.image.source=https://github.com/harderthanitneedstobe/kaniko-ci
