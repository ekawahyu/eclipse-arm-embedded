#!/bin/sh

# Make sure it is root to run it
if [ $(whoami) != "root" ]
then
    echo "This script should be executed as root"
    exit 1
fi

tar -xvjf ../src/kconfig-frontends-3.9.0.0.tar.bz2
cd kconfig-frontends-3.9.0.0
./configure --prefix=/usr/local
make
make install
cd ..
rm -R kconfig-frontends-3.9.0.0
