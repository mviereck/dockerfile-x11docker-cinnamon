# x11docker/cinnamon
#
# Run cinnamon desktop and systemd in docker.
#
# Sample image for possible systemd setup.
# - enabling/unmasking dbus and systemd-logind is essential.
# - Disabling services that fail anyway in container
#   speeds up systemd init time significantly.
#
# Use x11docker to run image. 
# Get x11docker script and x11docker-gui from github: 
#   https://github.com/mviereck/x11docker 
#
# Run with hardware acceleration and init system systemd:
#   x11docker --desktop --gpu --systemd x11docker/cinnamon
#
# Run single application (file manager):
#   x11docker x11docker/cinnamon nemo
#
# Use option --home to create a persistant home folder.

FROM fedora:27
# note: fedora and CentOS images can only build on fedora 
#       or CentOS. Or use automated build on docker hub. 
#       On other systems the build fails due to 
#       incompatibility of fedora and CentOS dnf installer
#       to docker's default aufs file systems.

RUN dnf -y update && \
    dnf -y install @cinnamon systemd sudo && \
    dnf clean all

# disable display manager because X is provided by x11docker
RUN systemctl mask lightdm gdm3 sddm lxdm slim kdm

# disable units failing in container
RUN systemctl mask auditd firewalld \
    libvirtd fwupd nfs-config rtkit-daemon \
    udisks2 upower

# disable units obviously slowing down startup
RUN systemctl mask dnfdaemon NetworkManager lm_sensors

# disable some rather useless units for a bit faster startup
RUN systemctl mask blk-availability colord \
    dmraid-activation dracut-shutdown gssproxy \
    iscsi-shutdown lvm2-lvmetad lvm2-monitor \
    ModemManager netcf-transaction \
    selinux-autorelabel-mark \
    systemd-hwdb-update systemd-update-done

# enable systemd-logind
RUN systemctl unmask systemd-logind

CMD cinnamon-session
