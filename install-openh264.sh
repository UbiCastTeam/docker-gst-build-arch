#!/bin/bash
# Copyright 2017, Florent Thiery
git clone https://aur.archlinux.org/openh264.git
cd openh264
makepkg -si --noconfirm --needed
cd ..
