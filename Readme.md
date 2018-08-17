# docker-gst-build

This docker image uses [gst-build](https://github.com/GStreamer/gst-build) to compile the latest gstreamer master from source with meson. It is based on Arch Linux, so it will always be bleeding edge.

It adds openh264 support.

## Building manually

```
docker build -t gst-build-img .
```

## Usage

```
docker run -it gst-build-img /opt/gstreamer/gst-uninstalled.py gst-launch-1.0 videotestsrc num-buffers=30 ! fakesink silent=false -v
```

## Running with hardware acceleration (vaapi)

```
docker run --privileged gst-build-img --rm --name vaapitest -v /dev:/dev -it gst-build /opt/gstreamer/gst-uninstalled.py gst-launch-1.0 videotestsrc num-buffers=30 ! vaapih264enc ! fakesink silent=false -v
```

## Running with systemd

```
docker run -d -v /sys/fs/cgroup:/sys/fs/cgroup:ro --tmpfs /tmp --tmpfs /run --name mygst gst-build-img /usr/lib/systemd/systemd
docker exec mygst /opt/gstreamer/gst-uninstalled.py gst-inspect-1.0 --version
docker exec -it mygst bash -c 'TERM=xterm bash'
```
