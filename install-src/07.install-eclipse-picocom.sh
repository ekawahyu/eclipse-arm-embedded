#!/bin/sh

# Make sure it is not root to run it
if [ $(whoami) != "tux" ]
then
    echo "This script should be executed as tux"
    exit 1
fi

# Extract Eclipse CDT and simple-template
tar -xzvf ../src/eclipse-cpp-juno-linux-gtk.tar.gz -C /home/tux
tar -xjvf ../src/simple-template.tar.bz2 -C /home/tux

# Creating Eclipse workspace with one ready to build project
mkdir -p /home/tux/workspace
cp -R /home/tux/simple-template/myproject /home/tux/workspace

# Creating shortcut on Desktop
echo "#!/bin/sh" > /home/tux/Desktop/Eclipse
echo "/home/tux/eclipse/eclipse" >> /home/tux/Desktop/Eclipse
chmod +x /home/tux/Desktop/Eclipse
echo "#!/bin/sh" > /home/tux/Desktop/picocom
echo "terminal -e picocom --b 115200 /dev/ttyUSB1 --imap lfcrlf --nolock" >> /home/tux/Desktop/picocom
chmod +x /home/tux/Desktop/picocom

# Showing messages of installation done and how to use it
echo "Installation done!"
echo "Double click 'Eclipse' on Desktop to start the IDE"
echo "Double click 'picocom' on Desktop to open serial terminal"
