#
# Docker Bionic image to build Yocto 3.2
#
FROM ubuntu:18.04

# Keep the dependency list as short as reasonable
RUN apt-get update && \
    apt-get install -y bc bison bsdmainutils build-essential curl locales \
        flex g++-multilib gcc-multilib git gnupg gperf lib32ncurses5-dev \
        lib32z1-dev libncurses5-dev git-lfs \
        libsdl1.2-dev libxml2-utils lzop \
        openjdk-8-jdk lzop wget git-core unzip \
        genisoimage sudo socat xterm gawk cpio texinfo \
        gettext vim diffstat chrpath rsync \
        python-mako libusb-1.0-0-dev exuberant-ctags \
        pngcrush schedtool xsltproc zip zlib1g-dev libswitch-perl && \
    apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

ADD https://commondatastorage.googleapis.com/git-repo-downloads/repo /usr/local/bin/
RUN chmod 755 /usr/local/bin/*

# ===== create user/setup environment =====
ARG USER=yocto_builder
RUN useradd -ms /bin/bash $USER         && \
    usermod -aG sudo $USER              

RUN git config --global color.ui false

# The persistent data will be in these two directories, everything else is
# considered to be ephemeral
#VOLUME ["/tmp/ccache", "/aosp"]

# Improve rebuild performance by enabling compiler cache
ENV USE_CCACHE 1
ENV CCACHE_DIR /home/$USER/.ccache

# some QT-Apps/Gazebo do not show controls without this
ENV QT_X11_NO_MITSHM 1

# Set the locale
RUN locale-gen en_US.UTF-8
ENV LANG en_US.UTF-8
 
USER $USER
