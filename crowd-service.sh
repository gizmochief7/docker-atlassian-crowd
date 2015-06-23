#!/bin/sh

SERVER_XML="${ATL_HOME}/apache-tomcat/conf/server.xml"

# Remove any previous proxy configuration.
sed -E 's/ proxyName="[^"]*"//g' -i "${SERVER_XML}"
sed -E 's/ proxyPort="[^"]*"//g' -i "${SERVER_XML}"

# Add new proxy configuration if environment variables are set.
if [ ! -z "${TC_PROXYNAME}" ]; then
  sed -E "s|<Connector|<Connector proxyName=\"${TC_PROXYNAME}\"|g" \
      -i "${SERVER_XML}"
fi
if [ ! -z "${TC_PROXYPORT}" ]; then
  sed -E "s|<Connector|<Connector proxyPort=\"${TC_PROXYPORT}\"|g" \
      -i "${SERVER_XML}"
fi

exec "${ATL_HOME}/apache-tomcat/bin/catalina.sh" run
