FROM ubuntu:latest
SHELL ["/bin/bash", "-c"]

RUN apt-get update -y \
    && apt-get upgrade -y

RUN apt-get install -y \
    sudo \
    make \
    git
 #   doxygen \
 #   graphviz \
 #   cmake

RUN apt-get install -y \
     python \
     cmake \
     default-jre \
#    build-essential \
#    libmicrohttpd-dev \
#    libconfig9 \
#    ffmpeg \
#    libavutil-dev \
#    libavcodec-dev \
#    libavformat-dev \
#    libconfig-dev \
#    libjansson-dev \
#    libnice-dev \
#    libssl-dev \
#    libsofia-sip-ua-dev \
#    libglib2.0-dev \
#    libopus-dev \
#    libogg-dev \
#    libini-config-dev \
#    libcollection-dev \
#    pkg-config \
#    gtk-doc-tools \
#    gengetopt \
     libtool \
     autotools-dev \
     automake

# Emscripten install
RUN cd ~ \
    && git clone https://github.com/emscripten-core/emsdk.git \
    && cd emsdk \
    && git pull \
    && ./emsdk install latest \
    && ./emsdk activate latest \
    && source /root/emsdk/emsdk_env.sh \
    && ./emsdk install latest-upstream

RUN cd ~ \
    && git clone https://github.com/jedisct1/libsodium --branch stable \
    && cd libsodium \
    && ./configure  \
    && make \
    && make check \
    && sudo make install


RUN cd ~/libsodium \
    && source /root/emsdk/emsdk_env.sh \
    && source ./dist-build/emscripten.sh --standard


#COPY src /root/src/
RUN  mkdir /root/src
RUN  mkdir /root/html


RUN apt-get install nginx -y
COPY nginx.conf /etc/nginx/nginx.conf
RUN sudo nginx -t

EXPOSE  80
 
COPY entrypoint.sh /root/entrypoint.sh
ENTRYPOINT ["/root/entrypoint.sh"]


#RUN cp -rp ~/janus-gateway/certs /opt/janus/share/janus
#COPY cert/*.* /opt/janus/share/janus/certs/

#COPY conf/*.jcfg /opt/janus/etc/janus/

# copy demo sources to container 
#COPY html /root/janus-gateway/

#COPY util/convert-mjr-to-webm.sh /opt/janus/share/janus/recordings/
#RUN  chmod +x /opt/janus/share/janus/recordings/convert-mjr-to-webm.sh

#RUN  mkdir /opt/janus/share/janus/recordings/list

#COPY nginx/nginx.conf /etc/nginx/nginx.conf

#EXPOSE 80 443 7088 8088 8089 8188 
#EXPOSE 10000-10200/udp

#CMD sudo nginx -t && service nginx restart \
#    && /opt/janus/bin/janus -F /opt/janus/etc/janus -C /opt/janus/etc/janus/janus.jcfg --nat-1-1=${DOCKER_IP}

