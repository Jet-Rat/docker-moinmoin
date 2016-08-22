FROM ubuntu:14.04

RUN apt-get -y update \
	&& apt-get -y install --no-install-recommends \
		aptitude \
		vim \
	&& rm -rf /var/lib/apt/lists/*

ENV NGINX_VERSION 1.10.1-1~trusty

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

ENV MOINMOIN_VERSION 1.9.8
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

COPY moin.wsgi /tmp/moin.wsgi
COPY uwsgi.xml /tmp/uwsgi.xml
COPY moin.conf /tmp/moin.conf

RUN cd ${MOINMOIN_HOME}/moin-${MOINMOIN_VERSION} \
	&& python2.7 setup.py install \
	&& cp -r wiki ${MOINMOIN_HOME}/wiki \
	&& cd ${MOINMOIN_HOME}/wiki \
	&& cp config/wikiconfig.py \
		/tmp/moin.wsgi \
		/tmp/uwsgi.xml \
		. \
	&& chown www-data:www-data -R ${MOINMOIN_HOME} \
	&& cp /tmp/moin.conf /etc/init/moin.conf


EXPOSE 80 443

CMD ["bash"]
