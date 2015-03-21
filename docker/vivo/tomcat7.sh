#!/bin/sh
set -eu

exec /etc/tomcat/tomcat-config.sh
exec /sbin/setuser tomcat7 ${CATALINA_HOME}/bin/catalina.sh run