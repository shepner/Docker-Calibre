FROM ubuntu:trusty

###########################################################################################
# general settings
ENV \
  HOME=/docker \
  TERM=xterm \
  DEBIAN_FRONTEND=noninteractive
  #LANG='en_US.UTF-8' LANGUAGE='en_US:en' LC_ALL='en_US.UTF-8'
  
RUN mkdir -p $HOME

###########################################################################################
# prep to install software
RUN \
  apt-get update \
  && apt-get -y upgrade \
  && apt-get -y dist-upgrade

###########################################################################################
# general utils
RUN apt-get install -y wget
#    python \
#    python-numpy \
#    unzip 
    
###########################################################################################
# X
RUN apt-get install -y Xvfb

ENV DISPLAY=:1

###########################################################################################
# VNC
# noVNC webport, connect via http://IP:6900/?password=vncpassword
RUN \
  apt-get install -y \
    git \
    x11vnc \
  && git clone https://github.com/novnc/noVNC.git $HOME/noVNC \
  && ln -s $HOME/noVNC/vnc_lite.html $HOME/noVNC/index.html \
  && git clone https://github.com/novnc/websockify.git $HOME/noVNC/utils/websockify

ENV \
  NO_VNC_HOME=$HOME/noVNC \
  VNC_COL_DEPTH=24 \
  VNC_RESOLUTION=1280x1024 \
  VNC_PW=vncpassword \
  VNC_VIEW_ONLY=false \
  VNC_PORT=5900 \
  NO_VNC_PORT=6900
  
EXPOSE $VNC_PORT $NO_VNC_PORT

###########################################################################################
# window manager
RUN apt-get install -y openbox

###########################################################################################
# window manager application menu
RUN apt-get install -y menu

###########################################################################################
# firefox
RUN apt-get install -y firefox

###########################################################################################
# calibre
# NOTE: the actual installation will occur in startup.sh
RUN \
  apt-get install -y xz-utils \
  && mkdir -p $HOME/.config/calibre \
  && ln -s $HOME/.config/calibre /config \
  && ln -s $HOME/Calibre\ Library /Library

VOLUME ["/config"]
VOLUME ["/Library"]

EXPOSE 6080

###########################################################################################
# installation cleanup
RUN \
  apt-get autoclean \
  && apt-get autoremove \
  && rm -rf /var/lib/apt/lists/*

###########################################################################################
# startup tasks
ADD startup.sh $HOME/startup.sh

RUN chmod 555 $HOME/startup.sh

CMD $HOME/startup.sh

