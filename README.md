# x11docker/cinnamon

Run Cinnamon desktop in docker. Based on Debian.
 - Use [x11docker](https://github.com/mviereck/x11docker) to run GUI applications and desktop environments in docker images. 
 
Run desktop with:
```
x11docker --desktop --gpu --init=systemd x11docker/cinnamon
```
Run single application:
```
x11docker x11docker/cinnamon nemo
```

# Options:
 - Persistent home folder stored on host with   `--home`
 - Shared host file or folder with              `--share PATH`
 - Hardware acceleration with option            `--gpu`
 - Clipboard sharing with option                `--clipboard`
 - ALSA sound support with option               `--alsa`
 - Pulseaudio sound support with option         `--pulseaudio`
 - Language locale settings with                `--lang [=$LANG]`
 - Printing over CUPS with                      `--printer`
 - Webcam support with                          `--webcam`

See `x11docker --help` for further options.

# Extend base image
To add your desired applications, create your own Dockerfile with this image as a base. Example:
```
FROM x11docker/cinnamon
RUN apt-get update
RUN apt-get install -y midori
```

# Screenshot
![screenshot](https://raw.githubusercontent.com/mviereck/x11docker/screenshots/screenshot-cinnamon.png "Cinnamon desktop")
 
