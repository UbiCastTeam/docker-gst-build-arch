# https://github.com/s-bernard/docker-arch-systemd-kitchen/blob/master/Dockerfile
FROM archlinux/base

WORKDIR /root

ADD . /root

RUN \
    # First, update everything (start by keyring and pacman)
    pacman -Sy && \
    pacman -S archlinux-keyring --noconfirm --noprogressbar --quiet --needed && \
    pacman -S pacman --noconfirm --noprogressbar --quiet && \
    pacman-db-upgrade && \
    pacman -Su --noconfirm --noprogressbar --quiet && \
    # Install useful packages
    pacman -S --noconfirm --noprogressbar --quiet --needed \
        sudo systemd git base-devel rsync asp \
        python-gobject gobject-introspection \
        gstreamer gstreamer-vaapi gst-plugins-base gst-plugins-good gst-plugins-bad gst-python gst-libav \
        ttf-freefont \
        libva-utils libva-intel-driver \
        gtk-doc meson ninja

RUN echo 'en_GB.UTF-8 UTF-8' >> /etc/locale.gen && locale-gen && \
  # Because systemd is not installed in the same path across distributions
  # The /sbin/init link may or may not be provided by the base image
  if [ ! -e /sbin/init ]; then ln -s /lib/systemd/systemd /sbin/init; fi

ENV LANG=en_GB.UTF-8

# systemctl mask tmp.mount systemd-tmpfiles-setup.service && \
# RUN systemctl mask tmp.mount systemd-tmpfiles-setup.service && \

# makepkg will only run as user, not root
RUN echo "nobody ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/nobody
RUN mkdir -p /home/nobody/build && chown -R nobody: /home/nobody
USER nobody
ENV HOME=/home/nobody
ENV EDITOR=/bin/true
WORKDIR /home/nobody

USER root
RUN cp /root/install-openh264.sh /home/nobody
RUN cp /root/recompile-plugins-bad.sh /home/nobody

RUN chown -R nobody /home/nobody/
USER nobody
RUN /home/nobody/install-openh264.sh

# recompile stable gstreamer to add openh264 support
RUN /home/nobody/recompile-plugins-bad.sh

# build gstreamer master
USER root
RUN /root/gst-build.sh
