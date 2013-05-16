###############################################################################
#  
#  install-eclipse.sh
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

# Make sure it is not root to run it
if [ $(whoami) == "root" ]
then
    echo "This script should be executed as user"
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
