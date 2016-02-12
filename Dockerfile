FROM tomcat:8-jre8

MAINTAINER Fábio Matos <fabiomatos@gmail.com>

ARG OPENAM_VERSION=13.0.0
ARG OPENAM_KEYSTORE_PASSWORD=changeit

ENV OPENAM_DOWNLOAD_URL http://maven.forgerock.org/repo/releases/org/forgerock/openam/openam-server/${OPENAM_VERSION}/openam-server-${OPENAM_VERSION}.war
ENV CATALINA_OPTS="-Xmx2048m -server"

RUN curl -#fL "${OPENAM_DOWNLOAD_URL}" -o openam.war \
    && unzip openam.war -d $CATALINA_HOME/webapps/openam \
    && rm -f openam.war

RUN openssl req -new -newkey rsa:2048 -nodes -out /opt/server.csr -keyout /opt/server.key -subj "/C=DE/ST=Berlin/L=Berlin/O=Zalando SE/OU=Technology/CN=openam.dev" \
    && openssl x509 -req -days 365 -in /opt/server.csr -signkey /opt/server.key -out /opt/server.crt \
    && openssl pkcs12 -export -in /opt/server.crt -inkey /opt/server.key -out /opt/server.p12 -name tomcat -password pass:${OPENAM_KEYSTORE_PASSWORD} \
    && keytool -importkeystore -deststorepass ${OPENAM_KEYSTORE_PASSWORD} -destkeypass ${OPENAM_KEYSTORE_PASSWORD} -destkeystore /opt/server.keystore -srckeystore /opt/server.p12 -srcstoretype PKCS12 -srcstorepass ${OPENAM_KEYSTORE_PASSWORD} -alias tomcat

COPY server.xml ${CATALINA_HOME}/conf/

RUN sed -i "s/KEYSTORE_PASSWORD_PLACEHOLDER/${OPENAM_KEYSTORE_PASSWORD}/g" ${CATALINA_HOME}/conf/server.xml
