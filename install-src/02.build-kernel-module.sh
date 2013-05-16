#!/bin/sh

# Make sure it is root to run it
if [ $(whoami) != "root" ]
then
    echo "This script should be executed as root"
    exit 1
fi

# Asking the installation environment
echo "Are you installing Slitaz under VirtualBox [y/n]?"
read VIRTUALBOX

# Make sure VirtualBox Guest Additions is mounted
if [ $VIRTUALBOX == 'y' ]
then
    if [ -d /media/VBOXADDITIONS* ]
    then
        continue
    else
        echo "Cannot find VirtualBox Guest Additions setup"
        echo "Please mount the ISO image before building kernel module"
    fi
fi

# Build and install FTDI kernel module
if [ -f "/usr/src/kernel-patches/slitaz/config.org" ]
then
    continue
else
    echo "Building FTDI kernel module"
    cp /usr/src/kernel-patches/slitaz/config /usr/src/kernel-patches/slitaz/config.org
    cat /usr/src/kernel-patches/slitaz/config.org | sed -e 's/\# CONFIG_USB_SERIAL_FTDI_SIO.*/CONFIG_USB_SERIAL_FTDI_SIO=m/' > /usr/src/kernel-patches/slitaz/config
    /usr/bin/get-linux-source
    cd /usr/src/linux-2.6.37
    make CONFIG_USB_SERIAL_FTDI_SIO=m M=drivers/usb/serial
    mkdir -p /lib/modules/2.6.37-slitaz/kernel/drivers/usb/serial
    cp drivers/usb/serial/*.ko /lib/modules/2.6.37-slitaz/kernel/drivers/usb/serial/
    make firmware_install
fi

# Install VirtualBox Guest Additions
if [ $VIRTUALBOX == 'y' ]
then
    /media/VBOXADDITIONS*/VBoxLinuxAdditions.run
fi

# Adding modules to load automatically during every boot
if [ -f "/etc/rcS.conf.org" ]
then
    continue
else
    cp /etc/rcS.conf /etc/rcS.conf.org
    if [ $VIRTUALBOX == 'y' ]
    then
        echo "Activating FTDI and VirtualBox kernel modules"
        depmod -q
        modprobe ftdi_sio vboxguest vboxsf vboxvideo
        cat /etc/rcS.conf.org | sed -e 's/LOAD_MODULES=\"/LOAD_MODULES=\" vboxguest vboxsf vboxvideo ftdi_sio /' > /etc/rcS.conf
        cp /etc/slim.conf /etc/slim.conf.org
        cat /etc/slim.conf.org | sed -e 's/login_cmd/login_cmd VBoxClient-all \& /' > /etc/slim.conf
        rm /etc/X11/xorg.conf.d/10-ServerLayout.conf
        rm /etc/X11/xorg.conf.d/50-Monitor.conf
        rm /etc/X11/xorg.conf.d/60-Device.conf
        rm /etc/X11/xorg.conf.d/70-Screen.conf
    else
        echo "Activating FTDI kernel module"
        depmod -q
        modprobe ftdi_sio
        cat /etc/rcS.conf.org | sed -e 's/LOAD_MODULES=\"/LOAD_MODULES=\" ftdi_sio /' > /etc/rcS.conf
    fi
fi

# Creating mount point for vboxsf
if [ $VIRTUALBOX == 'y' ]
then
    mkdir -p /media/vboxshared
fi

# Showing a message to continue with another installation
echo "rebooting system in 5 seconds..."

# Delay 5 seconds
sleep 5

# Restarting computer
reboot