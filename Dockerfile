# Use phusion/baseimage as base image.
FROM phusion/baseimage:master
LABEL MAINTAINER="anthony@relle.co.uk"

# Use baseimage-docker's init system.
CMD ["/sbin/my_init"]

# Install prerequisites
RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get -y upgrade && \
	apt-get install -y libasound2
# Grab latest 64bit and install
RUN curl -o /root/xeoma_linux64.tgz https://felenasoft.com/xeoma/downloads/2020-02-13/linux/xeoma_linux64.tgz && \
	tar -xvzf /root/xeoma_linux64.tgz -C /root && \
	/root/xeoma.app -install -allmanual && \
	rm /root/xeoma_linux64.tgz

# Set up the force first run
RUN touch /root/firstrun

# Set up start up scripts
RUN mkdir /etc/service/xeoma
ADD xeoma.sh /etc/service/xeoma/run
RUN chmod +x /etc/service/xeoma/run

VOLUME /usr/local/Xeoma

# Clean up APT when done.
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Expose the port
EXPOSE 8090
