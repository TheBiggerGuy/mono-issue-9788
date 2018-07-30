FROM multiarch/debian-debootstrap:armhf-buster-slim as base

RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends apt-transport-https ca-certificates dirmngr gnupg && \
    apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 3FA7E0328081BFF6A14DA29AA6A19B38D3D831EF && \
    echo 'deb https://download.mono-project.com/repo/debian stable-stretch main' | tee /etc/apt/sources.list.d/mono-official-stable.list && \
    apt-get remove --purge --autoremove -y gnupg dirmngr

RUN apt-get update
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends curl ca-certificates iputils-ping \
        mono-runtime \
        cli-common \
        binfmt-support \
        ca-certificates-mono \
        mono-devel \
        msbuild \
        mono-runtime-dbg \
        gdb

ARG VIRTUALRADAR_VERSION=c5c95e272125ac6b0b1468104001a7ff75fb45b6
ARG VIRTUALRADAR_HASH=5a9c208c8654cf6038e40fceed7fcb717682a75de6ad75d5084403bc8ad6933d

RUN curl --output VirtualRadar.tar.gz -L "https://github.com/vradarserver/vrs/archive/${VIRTUALRADAR_VERSION}.tar.gz" && \
    sha256sum VirtualRadar.tar.gz && echo "${VIRTUALRADAR_HASH}  VirtualRadar.tar.gz" | sha256sum -c

RUN mkdir vrs && cd vrs && \
    tar -xvf ../VirtualRadar.tar.gz --strip-components=1
WORKDIR vrs

CMD msbuild
