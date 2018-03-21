#!/bin/bash
# Copyright 2017, Florent Thiery
curl https://aur.archlinux.org/cgit/aur.git/snapshot/packer.tar.gz | tar xz
cd packer
makepkg --syncdeps --noconfirm --needed
sudo pacman -U --noconfirm *.xz
packer -S --noconfirm openh264
