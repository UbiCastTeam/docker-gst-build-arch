#!/bin/bash
# Copyright 2017, Florent Thiery
set -e
git clone https://aur.archlinux.org/openh264.git
cd openh264
makepkg -si --noconfirm --needed
cd ..
