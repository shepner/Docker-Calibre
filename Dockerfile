FROM ubuntu:trusty

###########################################################################################
# general settings
ENV \
  HOME=/docker \
  PUID=1003 \
  PGID=1100 \
  TERM=xterm \
  DEBIAN_FRONTEND=noninteractive \
  LANG='en_US.UTF-8' LANGUAGE='en_US:en' LC_ALL='en_US.UTF-8'

USER $PUID:$PGID
WORKDIR $HOME

###########################################################################################
# prep to install software
RUN \
  apt-get update \
  && apt-get -y upgrade \
  && apt-get -y dist-upgrade

###########################################################################################
# general utils
#RUN \
#  apt-get install -y \
#    wget \
#    python \
#    python-numpy \
#    unzip 
    
###########################################################################################
# X
RUN apt-get install -y Xvfb

ENV DISPLAY=:1

###########################################################################################
# VNC
RUN \
  apt-get install -y \
    git \
    x11vnc \
  && git clone https://github.com/novnc/noVNC.git /root \
  && git clone https://github.com/novnc/websockify.git /root/noVNC/utils/websockify

ENV \
  NO_VNC_HOME=$HOME/noVNC \
  VNC_COL_DEPTH=24 \
  VNC_RESOLUTION=1280x1024 \
  VNC_PW=vncpassword \
  VNC_VIEW_ONLY=false \
  VNC_PORT=5900 \
  NO_VNC_PORT=6900  # noVNC webport, connect via http://IP:6900/?password=vncpassword
  
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
RUN \
  apt-get install -y xz-utils \
  && mkdir -p /root/.config/calibre \
  && ln -s /root/.config/calibre /config \
  && ln -s /root/Calibre\ Library /Library

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
#
ADD startup.sh /root/startup.sh
RUN chmod 0755 /root/startup.sh
CMD /root/startup.sh

