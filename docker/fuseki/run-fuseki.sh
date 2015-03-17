#!/bin/sh
port=3030

cd $FUSEKI_HOME

CLASSPATH=fuseki-server.jar:lib/ReconnectingSDB-0.2.jar:lib/mysql-connector-java-5.1.16-bin.jar:lib/commons-codec-1.6.jar:lib/httpclient-4.2.6.jar:lib/httpcore-4.2.5.jar:lib/jcl-over-slf4j-1.7.6.jar:lib/jena-arq-2.12.1.jar:lib/jena-core-2.12.1.jar:lib/jena-iri-1.1.1.jar:lib/jena-sdb-1.5.1.jar:lib/jena-tdb-1.1.1.jar:lib/log4j-1.2.17.jar:lib/slf4j-api-1.7.6.jar:lib/slf4j-log4j12-1.7.6.jar:lib/xercesImpl-2.11.0.jar:lib/xml-apis-1.4.01.jar
export CLASSPATH

java -cp $CLASSPATH -Xmx1200M org.apache.jena.fuseki.FusekiCmd  --desc fuseki-vivo.ttl --port=$port /vivo