# docker-gst-build

This docker image uses [gst-build](https://github.com/GStreamer/gst-build) to compile the latest gstreamer master from source with meson. It is based on Arch Linux, so it will always be bleeding edge.

## Building manually

```
docker build -t gst-build .
```

## Builds on docker hub

Builds are automatically generated on docker hub at https://hub.docker.com/r/fthiery/gstreamer-build-master, but only when this repo changes; running rebuild_docker_hub.sh will trigger a rebuild.

## Usage

```
docker run -it gst-build /opt/gstreamer/gst-uninstalled.py gst-launch-1.0 videotestsrc num-buffers=30 ! fakesink silent=false -v
```

## Running with hardware acceleration (vaapi)

```
docker run --privileged --name vaapitest -v /dev:/dev -it gst-build /opt/gstreamer/gst-uninstalled.py gst-launch-1.0 videotestsrc num-buffers=30 ! vaapih264enc ! fakesink silent=false -v
```

## Running with systemd

```
docker run -d -v /sys/fs/cgroup:/sys/fs/cgroup:ro --name mygst gst-build
docker exec mygst /opt/gstreamer/gst-uninstalled.py gst-inspect-1.0 --version
```
