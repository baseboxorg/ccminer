FROM ubuntu:16.04

MAINTAINER BitBuyIO <developer@bitbuy.io>
LABEL description="running minergate console using docker container by http://bit.ly/docker-minergate"

RUN apt-get update && \
    apt-get install -y ca-certificates wget git libglu1-mesa libxi-dev libxmu-dev && \
    rm -rf /var/lib/apt/lists/*

RUN 
git clone https://github.com/tpruvot/ccminer.git && \
cd ccminer && \
./autogen.sh && \
./configure && \
./build.sh
make install
    
ENV USER miner@bitbuy.io
ENV COIN -bcn

ENTRYPOINT minergate-cli -user $USER $COIN
