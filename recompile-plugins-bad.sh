#!/bin/bash
# Copyright 2017, Florent Thiery
# lets recompile plugins bad to enable openh264
asp export gst-plugins-bad
cd gst-plugins-bad
makepkg -is --noconfirm
cd ..
