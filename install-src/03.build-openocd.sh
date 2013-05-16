#!/bin/sh

# Make sure it is root to run it
if [ $(whoami) != "root" ]
then
    echo "This script should be executed as root"
    exit 1
fi

tar -xvjf ../src/openocd-0.7.0.tar.bz2
cd openocd-0.7.0
./configure --prefix=/usr/local --enable-ftdi --enable-ft2232_libftdi --enable-stlink --enable-jlink
make
make install
cd ..
rm -R openocd-0.7.0
cp ../src/ft2232d.cfg /usr/local/share/openocd/scripts/interface
chmod 644 /usr/local/share/openocd/scripts/interface/ft2232d.cfg
