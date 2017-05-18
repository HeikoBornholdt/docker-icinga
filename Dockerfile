FROM ubuntu:xenial
MAINTAINER Heiko Bornholdt "heiko@bornholdt.it"

RUN export DEBIAN_FRONTEND=noninteractive \
	&& \
	apt-get update \
	&& \
	apt-get install -y \
		icinga \
		nagios-nrpe-plugin \
		libnet-dns-perl \
	&& \
    apt-get clean \
    && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

#RUN mkdir /var/run/munin \
#	&& \
#	chown munin:munin /var/run/munin

ADD docker/run.sh /run.sh

VOLUME /etc/postfix/
VOLUME /etc/icinga/

EXPOSE 80

CMD ["/run.sh"]
