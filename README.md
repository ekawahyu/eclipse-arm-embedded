Eclipse-ARM-Embedded
====================

An attempt to provide an easy installation of open source software development environment for ARM embedded platform through a virtual machine (Windows and Mac) or natively (Linux).

System Requirement
------------------
1. PC with Windows, Linux or Apple computer with Mac OS X.
2. VirtualBox installation with its extension (download from http://www.virtualbox.org)
3. USB Flash 512MB at least for temporary installer use.

VirtualBox Version
------------------

VirtualBox 4.2.12


Developing ARM Embedded on a Virtual Machine
--------------------------------------------

You may wonder why you should be developing an ARM embedded application on a virtual machine instead of doing it natively. The use of a virtual machine simplifies thing, especially if you:

1. Are beginners to ARM Cortex-M/R open source development environment.
2. Are not willing to spend too much time in building the toolchains from source.
3. Want to work on multiple platform Windows, Linux and Mac.

Most free and open source softwares are developed for Linux environment. You may find some tools are ported to Windows and Mac natively, but not ALL of them are available. Sometimes you need to download a lot of source code and build from scratch here and there.

Computer speed are growing rapidly from year to year. Memory banks are cheap nowadays. Harddrive space are plenty. Running a virtual machine is seamless and installation can be done quickly and clean.


Supported Host Operating System
-------------------------------

Microsoft Windows (XP, 7 and 8), Mac OS X and Linux. Yeah, I can hear the chuckle there... why running linux inside a linux? Because you can!

Supported Guest Linux Distribution
----------------------------------

Slitaz-4.0 (native and virtual machine build)

If you are install Slitaz within VirtualBox, there will be an additional VirtualBox Guest Addition setup featuring video driver and shared folder between host and guests.

Why Slitaz?
-----------

Slitaz is known as the smallest linux distribution (iso size = 35 MB) with GUI and highly customizable. You can boot/install Slitaz from optical media, harddrive, USB flash or virtual machine like VirtualBox. Installation is fast and more importantly it boots in seconds! That is really hard to get with other linux distribution. For more information, please visit: http://www.slitaz.org


Getting Started - /vm
---------------------

If you are one of the impatient users, you can download a ready-to-use virtual disk image with Slitaz, GCC ARM Embedded toolchain, OpenOCD and Eclipse CDT installed. You need to install VirtualBox and its extension pack on your computer and once you are done, download one of the virtual machine provided inside /vm folder. Extract it and double click to run it.

Getting Started - /install-bin
------------------------------

If you are curious of what binaries and where to put, then download this installer scripts. You need to install VirtualBox and its extension pack on your computer and once you are done, follow the instruction of the installation script.

Getting Started - /install-src
------------------------------

If you are a geek and want to build everything from source, then download this installer scripts to learn each step I made and build it from scratch. This script will download linux kernel source to build the FTDI and VirtualBox Guest Additions kernel modules. You need to install VirtualBox and its extension pack on your computer and once you are done, follow the instruction of the installation script.

How to Mount Shared Folder
--------------------------

1. Create a folder named 'Shared' to be used as a shared folder on the host.
2. Open the virtual machine settings and add this folder under Shared Folders.
3. Inside the guest machine, open terminal and type 'mount -t vboxsf Shared /media/vboxshared'
4. Now you can exchange files between host and guests.

Known Bugs
----------

1. Wallpaper may not be drawn correctly when you go full screen or resize the window of VirtualBox. The workaround for this is by exiting and relogin.
2. Issue of lost top/bottom panel. You can get it back by typing this on terminal:
        rm ~/.config/lxpanel/slitaz/panels/*
3. Opening Eclipse for the first time will not set the environment variables properly. You may workaround it by closing and reopen Eclipse.

To Do
-----

1. Script to do online installation instead of offline one.
2. Automount for VirtualBox shared folder.
3. Adding git.


Others
------

Within the installation, you may find 'myproject' under the Eclipse CDT installation. You can use this project to test your toolchain. You may also find a folder named simple-template with more examples for F4-DiscoverFree. F4-DiscoverFree is an ARM Cortex-M4 development board from Aisenke, released under CC-BY-SA 3.0 Unported and Simplified BSD License. For more information, visit: http://www.aisenke.com/nodinorobotics/f4discoverfree
