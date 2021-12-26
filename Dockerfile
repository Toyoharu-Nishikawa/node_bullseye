FROM node:17.3-bullseye

#ENV DEBIAN_FRONTEND noninteractive
#ENV TZ=Asia/Tokyo
ENV TZ=Asia/Tokyo
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone


# Install Node.js, Yarn and required dependencies
ADD ./data /home/data


RUN apt-get update \
  && apt install -y  g++ gcc-9 g++-9 openmpi-bin openmpi-doc libopenmpi-dev \
  # remove useless files from the current layer
  && rm -rf /var/lib/apt/lists/* \
  && rm -rf /var/lib/apt/lists.d/* \
  && apt-get autoremove \
  && apt-get clean \
  && apt-get autoclean \
  && cd /home/data/olb-1.4r0 \ 
  && make -j4 samples


CMD ["node"]
