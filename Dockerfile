FROM htmlgraphic/base:16.04
MAINTAINER Jason Gegere <jason@htmlgraphic.com>

# Install packages then remove cache package list information
ENV DEBIAN_FRONTEND noninteractive
RUN apt-get update && apt-get -yq install \
		wget \
		zip \
		unzip \
		vim \
		curl \
		iputils-ping \
		php7.0 \
		php7.0-json \
		php7.0-mcrypt \
		php7.0-mbstring \
		php7.0-xml \
		openssh-server \
		git && rm -rf /var/lib/apt/lists/*

RUN mkdir -p /var/run/sshd && sed -i "s/UsePrivilegeSeparation.*/UsePrivilegeSeparation no/g" /etc/ssh/sshd_config && sed -i "s/UsePAM.*/UsePAM no/g" /etc/ssh/sshd_config && sed -i "s/PermitRootLogin.*/PermitRootLogin yes/g" /etc/ssh/sshd_config

ADD run.sh /run.sh
RUN chmod +x /*.sh

# APACHE
RUN curl -sS https://getcomposer.org/installer | php && mv composer.phar /usr/local/bin/composer

# Environment variables contained within build container.
ENV PATH="~/.composer/vendor/bin:$PATH" \
	AUTHORIZED_KEYS=$AUTHORIZED_KEYS

EXPOSE 22
CMD ["/run.sh"]
