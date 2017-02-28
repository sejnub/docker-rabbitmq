# docker-rabbitmq

This repository contains a **Dockerfile** for RabbitMQ on a Raspberry Pi based on [RabbitMQ](http://www.rabbitmq.com/)

## Status and rights

AFAIK stable but needs more documentation. 
Totally free to use by everyone.


## Base Docker Image

* [resin/rpi-raspbian](https://hub.docker.com/r/resin/rpi-raspbian/)



## Usage

### Build
    HB_RABBITMQ_DEFAULT_USER=!!!
    HB_RABBITMQ_DEFAULT_PASS=!!!
    cd ~; rm -rf docker-rabbitmq; 
    cd ~; git clone https://github.com/sejnub/docker-rabbitmq.git; 
    cd ~/docker-rabbitmq; docker build --build-arg HB_RABBITMQ_DEFAULT_USER=$HB_RABBITMQ_DEFAULT_USER --build-arg HB_RABBITMQ_DEFAULT_PASS=$HB_RABBITMQ_DEFAULT_PASS -t sejnub/rabbitmq .
    
    eof

### Run `rpi-rabbitmq`

    docker rm -f rabbitmq; docker run -it -p 5672:5672 -p 15672:15672 -p 1883:1883 --name rabbitmq                                                   sejnub/rabbitmq bash
    docker rm -f rabbitmq; docker run  -d -p 5672:5672 -p 15672:15672 -p 1883:1883 --name rabbitmq                                                   sejnub/rabbitmq 
    docker rm -f rabbitmq; docker run  -d -p 5672:5672 -p 15672:15672 -p 1883:1883 --name rabbitmq -v <log-dir>:/data/log -v <data-dir>:/data/mnesia sejnub/rabbitmq
    
    eof



--env-file /usr/local/etc/hb-credentials.env 
