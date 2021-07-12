#!/bin/sh

echo "Create location for sickchill"
mkdir -p /usr/local/app

echo "Download sickchill repo"
git clone https://github.com/SickChill/SickChill.git /usr/local/app/sickchill

echo "Updating dependencies"
pip install --upgrade pip
pip install --upgrade virtualenv

echo "Create sickchill user"
pw user add sickchill -c "Sickchill" -d /nonexistent -s /usr/bin/nologin -w no
chown -R sickchill:sickchill /usr/local/app/sickchill

mkdir -p /.cargo
chown -R sickchill:sickchill /.cargo

echo "Installing SickChill service"
mkdir -p /usr/local/etc/rc.d
cp /usr/local/app/sickchill/contrib/runscripts/init.freebsd /usr/local/etc/rc.d/sickchill

echo "Executing SickChill service"
chmod u+x /usr/local/etc/rc.d/sickchill
sysrc "sickchill_enable=YES"
service sickchill start