#!/bin/bash

# For PiCamera if attached
modprobe bcm2835-v4l2

# Copy default configuration if doesn't exists
CONFIG=/etc/motioneye/motioneye.conf
test -e "${CONFIG}" || cp /usr/share/motioneye/extra/motioneye.conf.sample "${CONFIG}"

# Set the server name
if [ -n "${SERVER_NAME}" ]; then
    MOTIONEYE_SERVER_NAME="${SERVER_NAME}"
else
    MOTIONEYE_SERVER_NAME="${RESIN_DEVICE_NAME_AT_INIT}"
fi
grep -q "^server_name " ${CONFIG} && sed "s/^server_name.*$/server_name ${MOTIONEYE_SERVER_NAME}/" -i $CONFIG ||
    sed "$ a\server_name ${MOTIONEYE_SERVER_NAME}" -i $CONFIG

if [ -n "${TIMEZONE}" ]; then
    echo "Setting timezone: ${TIMEZONE}"
    echo "$TIMEZONE" > /etc/timezone
    rm /etc/localtime && dpkg-reconfigure -f noninteractive tzdata
fi

# Start avahi
/usr/sbin/avahi-daemon -s &

# Start MotionEye server
/usr/local/bin/meyectl startserver -c /etc/motioneye/motioneye.conf
