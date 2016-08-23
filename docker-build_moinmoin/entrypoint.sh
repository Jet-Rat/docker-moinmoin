#!/bin/bash

NGINX_CONF='/etc/nginx/conf.d/nginx_moin.conf'
WIKI_CONF='/srv/www/moin/wiki/wikiconfig.py'

if [ -z "${NGINX_SERVNAME}" ]; then NGINX_SERVNAME='localhost';fi
if [ -z "${WIKI_NAME}" ]; then WIKI_NAME='Untitled Wiki';fi
if [ -z "${FRONT_PAGE}" ]; then FRONT_PAGE='StartingPage';fi
if [ -z "${WIKI_SUPERUSER}" ]; then WIKI_SUPERUSER='superuser';fi
if [ -z "${DEFAULT_LANG}" ]; then DEFAULT_LANG='en';fi

sed -i "s/DOCKER_NGINX_SERVNAME/${NGINX_SERVNAME}/" ${NGINX_CONF};
sed -i "s/DOCKER_WIKI_NAME/${WIKI_NAME}/" ${WIKI_CONF};
sed -i "s/DOCKER_FRONT_PAGE/${FRONT_PAGE}/" ${WIKI_CONF};
sed -i "s/DOCKER_WIKI_SUPERUSER/${WIKI_SUPERUSER}/" ${WIKI_CONF};
sed -i "s/DOCKER_DEFAULT_LANG/${DEFAULT_LANG}/" ${WIKI_CONF};

service uwsgi start

/usr/sbin/nginx
