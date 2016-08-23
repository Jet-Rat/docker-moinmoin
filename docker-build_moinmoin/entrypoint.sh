#!/bin/bash

NGINX_CONF='/etc/nginx/conf.d/moinmoin.conf'

if [ -z "${NGINX_SERVNAME}" ]; then NGINX_SERVNAME='localhost';fi
sed -i "s/DOCKER_NGINX_SERVNAME/${NGINX_SERVNAME}/" ${NGINX_CONF};

service uwsgi start

/usr/sbin/nginx
