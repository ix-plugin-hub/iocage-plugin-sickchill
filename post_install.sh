#!/bin/sh
# Create user and set up the directorys
pw useradd -n sickchill -c "Sickchill" -s /sbin/nologin -w no
fetch https://github.com/SickChill/SickChill/archive/master.tar.gz
tar xfz master.tar.gz -C /usr/local/
mv /usr/local/SickChill-master /usr/local/sickchill
chown -R sickchill:sickchill /usr/local/sickchill
mkdir /usr/local/etc/rc.d

# Enable
sysrc -f /etc/rc.conf sickchill_enable="YES"

# Copy the init script where it's useful
cp /usr/local/sickchill/runscripts/init.freebsd /usr/local/etc/rc.d/sickchill
chmod +x /usr/local/etc/rc.d/sickchill

# Start the service
service sickchill start
