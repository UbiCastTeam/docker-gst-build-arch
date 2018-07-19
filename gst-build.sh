#!/bin/bash
FOLDER=/opt/gstreamer
mkdir -p $FOLDER
git clone https://github.com/GStreamer/gst-build.git $FOLDER
cd $FOLDER
meson -Dpython=enabled -Dsharp=disabled -Drtsp_server=disabled -Dges=disabled -Dlibav=disabled build
cd build
ninja
ln -sf /opt/gstreamer/gst-uninstalled.py /usr/local/bin
echo "Now run: gst-uninstalled.py"
