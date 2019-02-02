FROM ubuntu:trusty

ENV DEBIAN_FRONTEND noninteractive

RUN \
  apt-get update \
  && apt-get -y upgrade \
  && apt-get -y dist-upgrade

# install desktop env
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
    menu \
  && git clone https://github.com/novnc/noVNC.git /root \
  && git clone https://github.com/novnc/websockify.git /root/noVNC/utils/websockify

# setup app specific items
RUN \
  apt-get install -y xz-utils \
  && mkdir -p /root/.config/calibre \
  && ln -s /root/.config/calibre /config \
  && ln -s /root/Calibre\ Library /Library
VOLUME ["/config"]
VOLUME ["/Library"]
EXPOSE 6080

# installation cleanup
RUN \
  apt-get autoclean \
  && apt-get autoremove \
  && rm -rf /var/lib/apt/lists/*

ADD startup.sh /root/startup.sh
RUN chmod 0755 /root/startup.sh
CMD /root/startup.sh

