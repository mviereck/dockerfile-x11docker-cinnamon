# x11docker/cinnamon

Run Cinnamon desktop in docker. 
 - Use x11docker to run image. 
 - Get x11docker from github: https://github.com/mviereck/x11docker 

Run desktop with:
```
x11docker --desktop --dbus-system x11docker/cinnamon
```
Run single application:
```
x11docker x11docker/cinnamon nemo
```

# Options:
 - Persistent home folder stored on host with   `--home`
 - Shared host folder with                      `--sharedir DIR`
 - Hardware acceleration with option            `--gpu`
 - Clipboard sharing with option                `--clipboard`
 - Sound with                                   `--pulseaudio`
 - Language locale setting with                 `--lang $LANG`

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
 
