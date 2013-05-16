#!/bin/sh

# Make sure it is root to run it
if [ $(whoami) != "root" ]
then
    echo "This script should be executed as root"
    exit 1
fi

# Adding alternative mirrors, in case one is down
cp ../src/mirror /var/lib/tazpkg/

# Dependencies for building FTDI driver
tazpkg get-install linux-source
tazpkg get-install linux-api-headers
tazpkg get-install linux-module-headers
tazpkg get-install bzip2

# Dependencies to build with gcc
tazpkg get-install make

# Dependencies to run Eclipse
tazpkg get-install java-jre

# Dependencies to build OpenOCD
tazpkg get-install libftdi
tazpkg get-install libftdi-dev
tazpkg get-install libusb
tazpkg get-install libusb-dev

# Dependencies to build kconfig-frontends
tazpkg get-install gperf

# Dependencies to execute NuttX build script
tazpkg get-install bash
