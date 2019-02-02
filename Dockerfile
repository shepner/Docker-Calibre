FROM ubuntu:trusty

ENV DEBIAN_FRONTEND noninteractive

RUN \
  apt-get update \
  && apt-get -y upgrade \
  && apt-get -y dist-upgrade

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

RUN \
  apt-get autoclean \
  && apt-get autoremove \
  && rm -rf /var/lib/apt/lists/*


#echo 'deb http://archive.ubuntu.com/ubuntu trusty main universe restricted' > /etc/apt/sources.list && \
#echo 'deb http://archive.ubuntu.com/ubuntu trusty-updates main universe restricted' >> /etc/apt/sources.list && \

# Install packages needed for app
#export DEBCONF_NONINTERACTIVE_SEEN=true DEBIAN_FRONTEND=noninteractive && \
#apt-get update && \
#apt-get install -y ImageMagick && \

# Install steps for X app
#wget -nv -O- https://raw.githubusercontent.com/kovidgoyal/calibre/master/setup/linux-installer.py | sudo python -c "import sys; main=lambda:sys.stderr.write('Download failed\n'); exec(sys.stdin.read()); main()" && \
#mkdir -p /etc/my_init.d

ADD startup.sh /startup.sh
RUN chmod 0755 /startup.sh

CMD /startup.sh

# Place whater volumes and ports you want exposed here:
#VOLUME ["/Library"]
EXPOSE 6080


