FROM ubuntu:14.04

ENV NGINX_VERSION 1.10.1-1~trusty

RUN apt-key adv --keyserver hkp://pgp.mit.edu:80 \
		--recv-keys 573BFD6B3D8FBC641079A6ABABF5BD827BD9BF62 \
	&& echo "deb http://nginx.org/packages/ubuntu/ trusty nginx" \
		>> /etc/apt/sources.list \
	&& apt-get -y update \
	&& apt-get -y install --no-install-recommends \
		aptitude \
		vim \
		ca-certificates \
		nginx=${NGINX_VERSION} \
		nginx-module-xslt \
		nginx-module-geoip \
		nginx-module-image-filter \
		nginx-module-perl \
		nginx-module-njs \
		gettext-base


EXPOSE 80 443

CMD ["bash"]
