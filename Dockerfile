# x11docker/cinnamon
# 
# Run cinnamon desktop in docker. 
# Use x11docker to run image. 
# Get x11docker from github: 
#   https://github.com/mviereck/x11docker 
#
# Run desktop with:
#   x11docker --desktop --systemd x11docker/cinnamon
#
# Run single application:
#   x11docker x11docker/cinnamon nemo
#
# You can add hardware acceleration with option:       --gpu
# You can add sound with option:                       --pulseaudio 
# You can share clipboard with option:                 --clipboard
# You can create a persistent home folder with option: --home
# See x11docker --help for further options.
#

FROM debian:buster
ENV DEBIAN_FRONTEND noninteractive

# language 
RUN apt-get update && \
    apt-get install -y apt-utils locales && \
    echo "en_US.UTF-8 UTF-8" >/etc/locale.gen && \
    dpkg-reconfigure locales && \
    locale-gen && \
    update-locale LANG=en_US.UTF-8 && \
    apt-get upgrade -y && \
    rm -rf /var/lib/apt/lists/*
ENV LC_ALL en_US.UTF-8
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US.UTF-8

# cinnamon
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
            cinnamon cinnamon-l10n && \
    rm -rf /var/lib/apt/lists/*

# utils
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
            dconf-cli gedit gnome-system-monitor gnome-terminal \
            psmisc pulseaudio sudo synaptic xdg-user-dirs-gtk && \
    rm -rf /var/lib/apt/lists/*

ENV DEBIAN_FRONTEND newt

# create startscript 
RUN echo "#! /bin/sh\n\
[ -e \$HOME/.cinnamon ] || {\n\
  dconf write /org/cinnamon/desktop/background/picture-uri \"'file:///usr/share/backgrounds/gnome/Waterfalls.jpg'\"\n\
}\n\
exec cinnamon-session\n\
" > /usr/local/bin/start && chmod +x /usr/local/bin/start 

CMD start
