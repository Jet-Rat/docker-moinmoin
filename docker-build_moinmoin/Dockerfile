FROM ubuntu:14.04

ENV NGINX_VERSION 1.10.2-1~trusty

RUN apt-key adv --keyserver hkp://pgp.mit.edu:80 \
		--recv-keys 573BFD6B3D8FBC641079A6ABABF5BD827BD9BF62 \
	&& echo "deb http://nginx.org/packages/ubuntu/ trusty nginx" \
		>> /etc/apt/sources.list \
	&& apt-get -y update \
	&& apt-get -y install --no-install-recommends \
		gettext-base \
		ca-certificates \
		nginx=${NGINX_VERSION} \
		nginx-module-xslt \
		nginx-module-geoip \
		nginx-module-image-filter \
		nginx-module-perl \
		nginx-module-njs \
		;

ENV MOINMOIN_VERSION 1.9.9
ENV MOINMOIN_HOME /srv/www/moin

RUN apt-get -y update \
	&& apt-get -y install --no-install-recommends \
		wget \
	&& wget --progress=bar:force http://static.moinmo.in/files/moin-${MOINMOIN_VERSION}.tar.gz \
	&& mkdir -p ${MOINMOIN_HOME} \
	&& echo "Extracting MoinMoin archive moin-${MOINMOIN_VERSION}.tar.gz" \
	&& tar -xzf moin-${MOINMOIN_VERSION}.tar.gz -C ${MOINMOIN_HOME} \
	&& echo "Extraction finished" \
	&& rm -rf /var/lib/apt/lists/* moin-${MOINMOIN_VERSION}.tar.gz

RUN apt-get -y update \
	&& apt-get -y install --no-install-recommends \
		python2.7 \
		uwsgi \
		uwsgi-plugin-python \
	&& rm -rf /var/lib/apt/lists/*

COPY nginx.conf /etc/nginx/nginx.conf
COPY nginx_moin.conf /etc/nginx/conf.d/nginx_moin.conf
COPY moin.wsgi /tmp/moin.wsgi
COPY uwsgi_moin.ini /etc/uwsgi/apps-available/uwsgi_moin.ini
COPY wikiconfig.py /srv/www/moin/wiki/wikiconfig.py
COPY moin_ru-en.tar.gz /moin_ru-en.tar.gz


ENV ENTRYPOINT_FILE /usr/local/sbin/entrypoint.sh

COPY entrypoint.sh ${ENTRYPOINT_FILE}

RUN cd ${MOINMOIN_HOME}/moin-${MOINMOIN_VERSION} \
	&& python2.7 setup.py install \
	&& cp -r wiki ${MOINMOIN_HOME} \
	&& cp /tmp/moin.wsgi ${MOINMOIN_HOME}/wiki \
	&& mkdir /etc/moin \
	&& ln -s /srv/www/moin/wiki/wikiconfig.py /etc/moin/wikiconfig.py \
	&& tar -xzf /moin_ru-en.tar.gz -C / \
	&& chown www-data:www-data -R ${MOINMOIN_HOME} \
	&& ln -s /etc/uwsgi/apps-available/uwsgi_moin.ini /etc/uwsgi/apps-enabled/uwsgi_moin.ini \
	&& mv /etc/nginx/conf.d/default.conf /etc/nginx/conf.d/default.conf.orig \
	&& usermod -aG www-data nginx \
	&& chmod 554 ${ENTRYPOINT_FILE} \
	&& ln -s ${ENTRYPOINT_FILE} /entrypoint.sh \
	&& rm -rf /moin_ru-en.tar.gz ${MOINMOIN_HOME}/moin-${MOINMOIN_VERSION}


ENV MARKDOWN_VERSION 2.6.7

RUN cd ${MOINMOIN_HOME}/wiki/data/plugin/parser \
	&& wget -O text_markdown.py "https://moinmo.in/ParserMarket/Markdown?action=AttachFile&do=get&target=text_markdown.py" \
	&& cd /tmp/ \
#	&& wget  http://pypi.python.org/packages/source/M/Markdown/Markdown-${MARKDOWN_VERSION}.tar.gz \
	&& wget https://pypi.python.org/packages/d4/32/642bd580c577af37b00a1eb59b0eaa996f2d11dfe394f3dd0c7a8a2de81a/Markdown-2.6.7.tar.gz \
	&& tar -xvzf Markdown-${MARKDOWN_VERSION}.tar.gz \
	&& cd Markdown-${MARKDOWN_VERSION} \
	&& /usr/bin/python2.7 setup.py install \
	&& rm -rf /tmp/*


VOLUME ${MOINMOIN_HOME}/wiki

EXPOSE 80 443

CMD ["entrypoint.sh"]
