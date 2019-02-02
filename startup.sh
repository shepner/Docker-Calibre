#!/bin/bash
export DISPLAY=:1
Xvfb :1 -screen 0 1600x900x16 &
sleep 5
x11vnc -display :1 -nopw -listen localhost -xkb -ncache 10 -ncache_cr -forever &

openbox-session &  #window manager
#firefox &

wget -nv -O- https://raw.githubusercontent.com/kovidgoyal/calibre/master/setup/linux-installer.py | sudo python -c "import sys; main=lambda:sys.stderr.write('Download failed\n'); exec(sys.stdin.read()); main()"

#screen -d -m /opt/calibre/calibre

ln -s /root/noVNC/vnc_lite.html /root/noVNC/index.html
/root/noVNC/utils/launch.sh --vnc localhost:5900
