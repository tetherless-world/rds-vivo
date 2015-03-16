FROM phusion/baseimage:0.9.15
MAINTAINER Stephan Zednik "zednis2@rpi.edu"
ENV REFRESHED_AT 2015-01-28
 
# Install build dependencies
RUN \
  apt-get -q update && \
  apt-get -y install wget software-properties-common
 
# Install Oracle Java7 JDK
RUN \
  echo oracle-java7-installer shared/accepted-oracle-license-v1-1 select true | debconf-set-selections && \
  apt-add-repository -y ppa:webupd8team/java && \
  apt-get -q update && \
  apt-get install -y oracle-java7-installer && \
  rm -rf /var/cache/oracle-jdk7-installer
 
# Define commonly used JAVA_HOME variable
ENV JAVA_HOME /usr/lib/jvm/java-7-oracle
RUN echo "JAVA_HOME=/usr/lib/jvm/java-7-oracle" >> /etc/environment
 
# Install Apache Fuseki
ENV FUSEKI_BASE /opt/fuseki
 
RUN mkdir -p ${FUSEKI_BASE}
WORKDIR ${FUSEKI_BASE}

RUN \
  wget --quiet https://wiki.duraspace.org/download/attachments/33949103/jena-fuseki-1.1.1-vivo.tar.gz && \
  tar xvzf jena-fuseki-1.1.1-vivo.tar.gz && \
  cd jena-fuseki-1.1.1-vivo && \
  chmod +x fuseki-server s-*
 
ENV FUSEKI_HOME ${FUSEKI_BASE}/jena-fuseki-1.1.1-vivo

ADD run-fuseki.sh ${FUSEKI_HOME}/run-fuseki

# Add Configuration script to runit
ADD my_init.d/ /etc/my_init.d/

# Add script for starting fuseki as runit service
RUN mkdir /etc/service/fuseki
ADD fuseki.sh /etc/service/fuseki/run
RUN chmod +x /etc/service/fuseki/run

# Clean up APT when done.
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
 
VOLUME ["/etc/fuseki/conf.d"]
 
EXPOSE 3030

CMD ["/sbin/my_init"]

#WORKDIR $FUSEKI_HOME
#ENTRYPOINT ["./fuseki-run"]
#CMD ["start"]