#!/bin/bash
#export DISPLAY=:1
Xvfb :1 -screen 0 1600x900x16 &
sleep 5
x11vnc -display :1 -nopw -listen localhost -xkb -ncache 10 -ncache_cr -forever &

#install the latest version of calibre (which updates frequently)
wget -nv -O- https://download.calibre-ebook.com/linux-installer.sh | sudo sh /dev/stdin

#launch apps
openbox-session &  # window manager
#firefox &

$HOME/install_calibre.sh
$HOME/calibre/calibre &

$HOME/noVNC/utils/launch.sh --vnc localhost:5900
