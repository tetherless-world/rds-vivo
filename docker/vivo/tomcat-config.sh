#!/bin/bash

VIVO_CONTEXT_PATH=${VIVO_CONTEXT_PATH:-""}
ADMIN_USER=${ADMIN_USER:-admin}
ADMIN_PASS=${ADMIN_PASS:-tomcat}
MAX_UPLOAD_SIZE=${MAX_UPLOAD_SIZE:-52428800}

CATALINA_OPTS=${CATALINA_OPTS:-"-Xms1g -Xmx2g -XX:PermSize=512m -XX:MaxPermSize=4g -XX:+DisableExplicitGC"}
export CATALINA_OPTS="${CATALINA_OPTS}"

cat << EOF > ${CATALINA_BASE}/conf/tomcat-users.xml
<?xml version='1.0' encoding='utf-8'?>
<tomcat-users>
<user username="${ADMIN_USER}" password="${ADMIN_PASS}" roles="admin-gui,manager-gui"/>
</tomcat-users>
EOF

if [ -f "${CATALINA_BASE}/webapps/manager/WEB-INF/web.xml" ]
then
	sed -i "s#.*max-file-size.*#\t<max-file-size>${MAX_UPLOAD_SIZE}</max-file-size>#g" ${CATALINA_BASE}/webapps/manager/WEB-INF/web.xml
	sed -i "s#.*max-request-size.*#\t<max-request-size>${MAX_UPLOAD_SIZE}</max-request-size>#g" ${CATALINA_BASE}/webapps/manager/WEB-INF/web.xml
fi

#if [ ! -e "${CATALINA_BASE}/conf/server.xml.bak" ]
#then
#    cp ${CATALINA_BASE}/conf/server.xml ${CATALINA_BASE}/conf/server.xml.bak
#    xsltproc -stringparam DOC_BASE "${CATALINA_BASE}/webapps/vivo" -stringparam VIVO_PATH "${VIVO_CONTEXT_PATH}" /etc/tomcat/server.xsl ${CATALINA_BASE}/conf/server.xml > ${CATALINA_BASE}/conf/server.xml.new
#    cp ${CATALINA_BASE}/conf/server.xml.new ${CATALINA_BASE}/conf/server.xml
#fi