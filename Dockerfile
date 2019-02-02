FROM ubuntu:trusty

ENV DEBIAN_FRONTEND noninteractive

RUN \
  apt-get update \
  && apt-get -y upgrade \
  && apt-get -y dist-upgrade

# install minimal desktop stuff
RUN \
  apt-get install -y \
    git \
    x11vnc \
    wget \
    python \
    python-numpy \
    unzip \
    Xvfb \
    firefox \
    openbox \
    geany \
    menu
  
RUN \
  cd /root \
  && git clone https://github.com/novnc/noVNC.git \
  && cd noVNC/utils \
  && git clone https://github.com/novnc/websockify.git websockify

# install app specific dependencies
RUN \
  apt-get install -y \
  xz-utils
VOLUME ["/root/Calibre\ Library"]
EXPOSE 6080

# system cleanup
RUN \
  apt-get autoclean \
  && apt-get autoremove \
  && rm -rf /var/lib/apt/lists/*

ADD startup.sh /root/startup.sh
RUN chmod 0755 /root/startup.sh
CMD /root/startup.sh

