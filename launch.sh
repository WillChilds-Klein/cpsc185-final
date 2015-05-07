#!/usr/bin/env bash

esc=$(printf '\033');
red="${esc}[31m";
green="${esc}[32m";
yellow="${esc}[33m";
blue="${esc}[34m";
none="${esc}[0m";


# set script's env for docker-machine
docker-machine active wiki && eval $(docker-machine env wiki)


echo "building wiki..."
docker build -q -t wiki_img wiki/ 1>/dev/null \
    && echo ${yellow}wiki built.${none} \
    || (echo ${red}wiki failed to build, exiting.${none} && exit 1)


echo "running wiki..."
docker run -d --name wiki --net host -p 127.0.0.1:80:80 wiki_img \
    && echo ${green}wiki launched${none} \
    || (echo ${red}wiki failed to launch, exiting.${none} && exit 1)


echo "building ths..."
docker build -q -t torbox-build tor-hs/ 1>/dev/null \
    && echo ${yellow}tor hidden service built.${none} \
    || (echo ${red}tor hidden service failed to build, exiting.${none} && exit 1)

echo "running ths..."
docker run -d --name torbox --net host torbox-build \
    && echo ${green}tor hidden service proxy launched${none} \
    || (echo ${red}tor hidden service proxy failed to launch, exiting.${none} && exit 1)

echo "Hidden Service Hostname: ${green}$(docker exec torbox cat /var/lib/tor/hidden_service/hostname)${none}"
exit $?
