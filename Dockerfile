FROM ubuntu:16.04

MAINTAINER BitBuyIO <developer@bitbuy.io>
LABEL description="running minergate console using docker container by http://bit.ly/docker-minergate"

RUN apt-get update && \
    apt-get install -y ca-certificates wget make git  libcurl4-openssl-dev g++ libssl-dev  gcc build-essential automake gawk libcurl4-openssl-dev libjansson-dev libc++-dev libgmp-dev python-dev libglu1-mesa libxi-dev libxmu-dev && \
    rm -rf /var/lib/apt/lists/*
    
  sudo apt-get -y install 

wget http://developer.download.nvidia.com/compute/cuda/repos/ubuntu1604/x86_64/cuda-repo-ubuntu1604_8.0.44-1_amd64.deb
dpkg -i cuda-repo-ubuntu1604_8.0.44-1_amd64.deb
apt update
apt-get install -y cuda-toolkit-8-0
rm cuda-repo-ubuntu1404_6.5-14_amd64.deb

RUN 
git clone https://github.com/tpruvot/ccminer.git && \
cd ccminer && \
./build.sh && \
make install
    
ENV USER miner@bitbuy.io
ENV COIN -bcn

ENTRYPOINT minergate-cli -user $USER $COIN
