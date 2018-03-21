# docker-gst-build

This docker image uses [gst-build](https://github.com/GStreamer/gst-build) to compile the latest gstreamer master from source with meson.

## Building

```
docker build -t gst-build
```

## Usage

```
docker run -it gst-build /opt/gstreamer/gst-uninstalled.py gst-launch-1.0 videotestsrc num-buffers=30 ! fakesink silent=false -v
```

## Running with hardware acceleration (vaapi)

```
docker run --privileged --name vaapitest -v /dev:/dev -it gst-build /opt/gstreamer/gst-uninstalled.py gst-launch-1.0 videotestsrc num-buffers=30 ! vaapih264enc ! fakesink silent=false
```
