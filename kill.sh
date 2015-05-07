#!/usr/bin/env bash

esc=$(printf '\033');
red="${esc}[31m";
green="${esc}[32m";
yellow="${esc}[33m";
blue="${esc}[34m";
none="${esc}[0m";


# set script's env for docker-machine
docker-machine active wiki && eval $(docker-machine env wiki)

containers=$(docker ps -aq | xargs)
if [[ -z ${containers} ]]; then
    echo "${red}no running containers!${none}"
    exit 1
fi

echo "killing containers ${yellow}${containers}${none}"
docker kill ${containers} \
    && echo ${green}success${none} \
    || (echo ${red}fail${none} && exit 1)

echo "removing containers ${yellow}${containers}${none}"
docker rm --force ${containers} \
    && echo ${green}success${none} \
    || (echo ${red}fail${none} && exit 1)

echo "done."
exit $?
