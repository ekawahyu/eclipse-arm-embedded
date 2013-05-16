###############################################################################
#  
#  install-tools.sh
# 
#  Created on: May 16, 2013
#      Author: Ekawahyu Susilo
# 
#  Copyright (c) 2013, Chongqing Aisenke Electronic Technology Co., Ltd.
#  All rights reserved.
#  
#  Redistribution and use in source and binary forms, with or without
#  modification, are permitted provided that the following conditions are met: 
#  
#  1. Redistributions of source code must retain the above copyright notice,
#     this list of conditions and the following disclaimer. 
#  2. Redistributions in binary form must reproduce the above copyright notice,
#     this list of conditions and the following disclaimer in the documentation
#     and/or other materials provided with the distribution. 
#  
#  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDER AND CONTRIBUTORS "AS IS"
#  AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
#  IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
#  ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE
#  LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
#  CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
#  SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
#  INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
#  CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
#  ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
#  POSSIBILITY OF SUCH DAMAGE.
#  
#  The views and conclusions contained in the software and documentation are
#  those of the authors and should not be interpreted as representing official
#  policies, either expressed or implied, of the copyright holder.
#  
###############################################################################

#!/bin/sh

# Make sure only root can run it
if [ $(whoami) != 'root' ]
then
    echo "You need to be root to run it"
    exit 1
fi

# Asking the installation environment
echo "Is Slitaz running in VirtualBox [y/n]?"
read VIRTUALBOX

# Adding alternative mirrors, in case one is down
cp ../src/mirror /var/lib/tazpkg/

# Install make, bzip2, gzip and java runtime environment
tazpkg get-install make
tazpkg get-install bzip2
tazpkg get-install gzip
tazpkg get-install java-jre

# Install libftdi and libusb
tazpkg get-install libftdi
tazpkg get-install libusb

# Unpack precompiled binaries and kernel modules
tar -xjvf local.tar.bz2 -C /usr
tar -xjvf serial.tar.bz2 -C /lib/modules/*-slitaz/kernel/drivers/usb
if [ $VIRTUALBOX == 'y' ]
then
    echo "Installing kernel modules"
    VB_VER=$(ls | grep VBox | sed -e 's/VBoxGuestAdditions-//' -e 's/.tar.bz2//')
    tar -xjvf misc.tar.bz2 -C /lib/modules/*-slitaz/kernel/drivers
    mkdir -p /opt
    tar -xjvf VBoxGuestAdditions-* -C /opt
    ln -s /opt/VBoxGuestAdditions-*/bin/VBoxClient-all /usr/bin/VBoxClient-all
    ln -s /opt/VBoxGuestAdditions-*/bin/VBoxClient /usr/bin/VBoxClient
    ln -s /opt/VBoxGuestAdditions-*/bin/VBoxControl /usr/bin/VBoxControl
    ln -s /opt/VBoxGuestAdditions-*/lib/VBoxGuestAdditions/mount.vboxsf /sbin/mount.vboxsf
    ln -s /opt/VBoxGuestAdditions-*/sbin/vbox-greeter /usr/sbin/vbox-greeter
    ln -s /opt/VBoxGuestAdditions-*/sbin/VBoxService /usr/sbin/VBoxService
    ln -s /opt/VBoxGuestAdditions-$VB_VER/lib/VBoxGuestAdditions /usr/lib/VBoxGuestAdditions
    ln -s /opt/VBoxGuestAdditions-$VB_VER/share/VBoxGuestAdditions /usr/share/VBoxGuestAdditions
    ln -s /opt/VBoxGuestAdditions-*/lib/VBoxOGLarrayspu.so /usr/lib/VBoxOGLarrayspu.so
    ln -s /opt/VBoxGuestAdditions-*/lib/VBoxOGLcrutil.so /usr/lib/VBoxOGLcrutil.so
    ln -s /opt/VBoxGuestAdditions-*/lib/VBoxOGLerrorspu.so /usr/lib/VBoxOGLerrorspu.so
    ln -s /opt/VBoxGuestAdditions-*/lib/VBoxOGLfeedbackspu.so /usr/lib/VBoxOGLfeedbackspu.so
    ln -s /opt/VBoxGuestAdditions-*/lib/VBoxOGLpackspu.so /usr/lib/VBoxOGLpackspu.so
    ln -s /opt/VBoxGuestAdditions-*/lib/VBoxOGLpassthroughspu.so /usr/lib/VBoxOGLpassthroughspu.so
    ln -s /opt/VBoxGuestAdditions-*/lib/VBoxOGL.so /usr/lib/VBoxOGL.so
    ln -s /usr/lib/VBoxGuestAdditions/vboxvideo_drv_19.so /usr/lib/X11/modules/drivers/vboxvideo_drv.so
    cp /opt/VBoxGuestAdditions-*/init/* /etc/init.d
    cp 60-vboxadd.rules /etc/udev/rules.d
    cp 98vboxadd-xclient.sh /etc/X11/xinit/xinitrc.d
fi

# Adding modules to load automatically during every boot
cp /etc/rcS.conf /etc/rcS.conf.org
if [ $VIRTUALBOX == 'y' ]
then
    echo "Activating kernel modules"
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
    depmod -q
    modprobe ftdi_sio
    cat /etc/rcS.conf.org | sed -e 's/LOAD_MODULES=\"/LOAD_MODULES=\" ftdi_sio /' > /etc/rcS.conf
fi

# Install bash shell
tazpkg get-install bash

# Creating mount point for vboxsf
if [ $VIRTUALBOX == 'y' ]
then
    mkdir -p /media/vboxshared
fi

# Showing a message to continue with another installation
echo "Installation done."
echo "Rebooting system in 5 seconds..."

# Delay 5 seconds
sleep 5

# Restarting computer
reboot
