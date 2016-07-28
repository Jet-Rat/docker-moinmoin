FROM ubuntu:14.04

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


EXPOSE 80 443

CMD ["bash"]
