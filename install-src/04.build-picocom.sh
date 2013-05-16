#!/bin/sh

# Make sure it is root to run it
if [ $(whoami) != "root" ]
then
    echo "This script should be executed as root"
    exit 1
fi

tar -xvzf ../src/picocom-1.7.tar.gz
cd picocom-1.7
make
cp picocom /usr/local/bin
cd ..
rm -R picocom-1.7
