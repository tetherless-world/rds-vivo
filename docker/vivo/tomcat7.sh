#!/bin/sh
set -eu

/etc/tomcat/tomcat-config.sh
exec /sbin/setuser tomcat7 ${CATALINA_HOME}/bin/catalina.sh run