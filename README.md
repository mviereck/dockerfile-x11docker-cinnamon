# x11docker/cinnamon

Run cinnamon desktop and systemd in docker.

Use x11docker to run image. Get x11docker script and x11docker-gui from github: https://github.com/mviereck/x11docker 

Examples:
 - Run with hardware acceleration and init system systemd:
   - `x11docker --desktop --gpu --systemd x11docker/cinnamon`
 - Run single application (file manager):
   - `x11docker x11docker/cinnamon nemo`

Use option --home to create a persistant home folder.

# Screenshot
![screenshot](https://raw.githubusercontent.com/mviereck/x11docker/screenshots/screenshot-cinnamon.png "Cinnamon desktop")
 
