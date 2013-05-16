#!/bin/sh

# Make sure it is root to run it
if [ $(whoami) != "root" ]
then
    echo "This script should be executed as root"
    exit 1
fi

tar -xvjf ../src/gcc-arm-none-eabi-4_7-2013q1-20130313-linux.tar.bz2
cd gcc-arm-none-eabi-4_7-2013q1
cp -R * /usr/local
cd ..
rm -R gcc-arm-none-eabi-4_7-2013q1
