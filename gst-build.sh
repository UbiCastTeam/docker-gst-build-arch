#!/bin/bash
FOLDER=/opt/gstreamer
mkdir -p $FOLDER
git clone https://github.com/GStreamer/gst-build.git $FOLDER
cd $FOLDER
meson -Denable_python=true -Ddisable_gstreamer_sharp=true -Ddisable_rtsp_server=true -Ddisable_gst_editing_services=true -Ddisable_gst_libav=true build
cd build
ninja
ln -sf /opt/gstreamer/gst-uninstalled.py /usr/local/bin
echo "Now run: gst-uninstalled.py"
