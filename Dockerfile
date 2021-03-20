FROM ubuntu:20.04
# Add .docker config dir
RUN mkdir -p /kaniko/.docker
COPY --from=
COPY --from=gcr.io/kaniko-project/executor:debug /kaniko/executor /usr/local/bin/kaniko
COPY kaniko/files/nsswitch.conf /etc/nsswitch.conf
ENV HOME /root
ENV USER root
ENV PATH /usr/local/bin:/bin:$PATH
ENV DOCKER_CONFIG /kaniko/.docker/
ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get update && apt-get install -y \
    curl \
    gnupg2 \
    lsb-release \
    software-properties-common \
    git \
    build-essential
