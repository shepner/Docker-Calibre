#!/bin/bash
#export DISPLAY=:1
Xvfb :1 -screen 0 1280x740x16 &

$HOME/install_calibre.sh

#Xvfb takes a while to start and needs to complete before x11vnc can be launched
#sleep 15
x11vnc -display :1 -nopw -listen localhost -xkb -ncache 10 -ncache_cr -forever &

#launch apps
openbox-session &  # window manager

#https://github.com/therecipe/qt/issues/775
export QT_QPA_PLATFORM=offscreen
$HOME/calibre/calibre &

$HOME/noVNC/utils/launch.sh --vnc localhost:5900
