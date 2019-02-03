#!/bin/bash

#install the latest version of calibre (which updates frequently)
#wget -nv -O- https://download.calibre-ebook.com/linux-installer.sh | sudo sh /dev/stdin
wget -nv -O- https://download.calibre-ebook.com/linux-installer.sh | sh /dev/stdin install_dir=~/calibre isolated=y

