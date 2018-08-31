# resin-motioneye

**WIP** A [MotionEye](https://github.com/ccrisan/motioneye) server deployed on resin.io.

## Usage

*   Navigate to the device's IP/hostname over `http` to open the interface
*   Alternatively enable the [public device URL](https://docs.resin.io/learn/manage/actions/#enable-public-device-url), and navigate to that to see the interface

The interface uses the default MotionEye credentials. There you can add your settings (cameras, etc) that are stored in a non-volatile way (in docker volumes).

### Configuration variables

Some device settings can be adjusted with Device/Fleet service variables. These should be set for the `motioneye` service:

*   `SERVER_NAME`: the name of the server in the MotionEye UI. If not set, then the device's name (from the [`RESIN_DEVICE_NAME_AT_INIT` variable](https://docs.resin.io/learn/develop/runtime/#environment-variables)) will be used automatically.
*   `TIMEZONE`: the device's local time, one of the timezone names from the [available time zones](https://en.wikipedia.org/wiki/List_of_tz_database_time_zones). If not set, the default UTC time is used.

### Notes

*   The current setup only supports ARMv7 devices (especially Raspberry Pi 3). Other device types are WIP
*   The default `docker-compose.yml` exposes 10 MotionEye camera streaming ports on the port range used by MotionEye by default (`8081-8090`), if need more than that, you need to edit the compose file.
