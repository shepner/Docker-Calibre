#!/bin/bash
#export DISPLAY=:1
Xvfb :1 -screen 0 1280x740x16 &
sleep 5
x11vnc -display :1 -nopw -listen localhost -xkb -ncache 10 -ncache_cr -forever &

#launch apps
openbox-session &  # window manager

$HOME/install_calibre.sh
$HOME/calibre/calibre &

$HOME/noVNC/utils/launch.sh --vnc localhost:5900
