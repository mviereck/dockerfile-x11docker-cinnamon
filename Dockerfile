# x11docker/cinnamon
# 
# Run cinnamon desktop in docker. 
# Use x11docker to run image. 
# Get x11docker from github: 
#   https://github.com/mviereck/x11docker 
#
# Run desktop with:
#   x11docker --desktop --init=systemd x11docker/cinnamon
#
# Run single application:
#   x11docker x11docker/cinnamon nemo
#
#
# Options:
# Persistent home folder stored on host with   --home
# Shared host file or folder with              --share PATH
# Hardware acceleration with option            --gpu
# Clipboard sharing with option                --clipboard
# ALSA sound support with option               --alsa
# Pulseaudio sound support with option         --pulseaudio
# Language setting with                        --lang [=$LANG]
# Printing over CUPS with                      --printer
# Webcam support with                          --webcam
#
# See x11docker --help for further options.

FROM debian:bullseye
ENV SHELL=/bin/bash
ENV LANG=en_US.UTF-8

# cleanup script for use after apt-get
RUN echo '#! /bin/sh\n\
env DEBIAN_FRONTEND=noninteractive apt-get autoremove -y\n\
apt-get clean\n\
find /var/lib/apt/lists -type f -delete\n\
find /var/cache -type f -delete\n\
find /var/log -type f -delete\n\
exit 0\n\
' > /cleanup && chmod +x /cleanup

# basics
RUN apt-get update && \
    echo $LANG UTF-8 > /etc/locale.gen && \
    env DEBIAN_FRONTEND=noninteractive apt-get install -y \
      locales && \
    update-locale --reset LANG=$LANG && \
    env DEBIAN_FRONTEND=noninteractive apt-get install -y \
      mesa-utils \
      mesa-utils-extra \
      libxv1 && \
    env DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
      ca-certificates \
      dbus-x11 \
      desktop-file-utils \
      libcups2 \
      libpulse0 \
      locales \
      menu-xdg \
      mime-support \
      procps \
      psmisc \
      xdg-user-dirs \
      xdg-utils \
      x11-xserver-utils && \
    /cleanup

# cinnamon and some utils
RUN apt-get update && \
    env DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
      cinnamon \
      cinnamon-l10n \
      gnome-icon-theme && \
    env DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
      dconf-cli \
      gedit \
      gnome-system-monitor \
      gnome-terminal \
      sudo \
      synaptic && \
    /cleanup

# startscript to set a background wallpaper
RUN echo '#! /bin/sh\n\
[ -e \$HOME/.cinnamon ] || {\n\
  dconf write /org/cinnamon/desktop/background/picture-uri \"file:///usr/share/backgrounds/gnome/Icetwigs.jpg\"\n\
}\n\
exec cinnamon-session\n\
' > /usr/local/bin/startcinnamon && chmod +x /usr/local/bin/startcinnamon

CMD ["/usr/local/bin/startcinnamon"]
