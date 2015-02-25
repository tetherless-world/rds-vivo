FROM phusion/baseimage:0.9.15
MAINTAINER Stephan Zednik <zednis2@rpi.edu>

ENV HOME /root

# Regenerate SSH host keys. baseimage-docker does not contain any, so you
# have to do that yourself. You may also comment out this instruction; the
# init system will auto-generate one during boot.
RUN /etc/my_init.d/00_regen_ssh_host_keys.sh

RUN apt-get -qq update

# Install build tools
RUN \
  apt-get update && \
  apt-get -y upgrade && \
  apt-get install -y build-essential && \
  apt-get install -y software-properties-common && \
  apt-get install -y apt-utils && \
  apt-get install -y python-software-properties && \
  apt-get install -y curl wget git unzip emacs man

# Install Java7 JDK
RUN \
  echo oracle-java7-installer shared/accepted-oracle-license-v1-1 select true | debconf-set-selections && \
  add-apt-repository -y ppa:webupd8team/java && \
  apt-get update && \
  apt-get install -y oracle-java7-installer && \
  rm -rf /var/cache/oracle-jdk7-installer

# Define commonly used JAVA_HOME variable
ENV JAVA_HOME /usr/lib/jvm/java-7-oracle
RUN echo "JAVA_HOME=/usr/lib/jvm/java-7-oracle" >> /etc/environment

# Install Ant
RUN apt-get install -y ant

# Install Tomcat7
RUN \
  apt-get install -y tomcat7 && \
  apt-get clean

ENV CATALINA_BASE /var/lib/tomcat7
ENV CATALINA_HOME /usr/share/tomcat7
ENV PATH $PATH:$CATALINA_HOME/bin
RUN echo "JAVA_HOME=/usr/lib/jvm/java-7-oracle" >> /etc/default/tomcat7

# Add script for configuring tomcat based on ENV variables
ADD docker/vivo/tomcat-config.sh /tomcat-config.sh
RUN chmod +x /tomcat-config.sh

# Add script for starting tomcat as runit service
RUN mkdir /etc/service/tomcat7
ADD docker/vivo/tomcat7.sh /etc/service/tomcat7/run
RUN chmod +x /etc/service/tomcat7/run

# Install VIVO

#ENV VIVO_DIST maint-rel-1.6.2
ENV VIVO_HOME /opt/vivo/home
ENV VIVO_DATA /usr/local/vivo/data
ENV VIVO_BUILD /opt/build

# Create VIVO required directories
RUN mkdir -p ${CATALINA_BASE}/temp
RUN mkdir -p ${CATALINA_HOME}/logs

ADD productMods ${VIVO_BUILD}/productMods
ADD rdf ${VIVO_BUILD}/rdf
ADD scripts ${VIVO_BUILD}/scripts
ADD solr ${VIVO_BUILD}/solr
ADD src ${VIVO_BUILD}/src
ADD themes ${VIVO_BUILD}/themes
ADD vitro ${VIVO_BUILD}/vitro
ADD vivo ${VIVO_BUILD}/vivo
ADD build.properties build.xml ${VIVO_BUILD}/

WORKDIR ${VIVO_BUILD}
RUN ant all

# copy runtime.properties to /etc/vivo where it is found by my-init configure script on start-up
RUN mkdir -p /etc/vivo
ADD runtime.properties /etc/vivo/

# Set permissions on all VIVO directories
RUN chown -R tomcat7:tomcat7 ${VIVO_HOME}
RUN chown -R tomcat7:tomcat7 ${VIVO_DATA}
RUN chown -R tomcat7:tomcat7 ${CATALINA_BASE}/temp
RUN chown -R tomcat7:tomcat7 ${CATALINA_BASE}/logs
RUN chown -R tomcat7:tomcat7 ${CATALINA_HOME}/logs

VOLUME ["${VIVO_HOME}", "${VIVO_DATA}"]

# Add vivo configuration script to runit
ADD docker/vivo/my_init.d/ /etc/my_init.d/

# Clean up APT when done.
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

EXPOSE 8080

# Use baseimage-docker's init system.
CMD ["/sbin/my_init"]