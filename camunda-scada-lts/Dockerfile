#
# Camunda
#
FROM camunda/camunda-bpm-platform:tomcat-7.15.0 AS camunda
#
# Source
#
FROM debian:10.9 AS scadalts-source
RUN apt-get update -qq && apt-get install -y git
ARG SCADALTS_COMMIT=fbd5000e2c66b53c4dc3ff0463f12c468c964d36
RUN git clone https://github.com/SCADA-LTS/Scada-LTS.git /usr/local/src/Scada-LTS
WORKDIR /usr/local/src/Scada-LTS
RUN git checkout ${SCADALTS_COMMIT}
COPY patches /usr/local/src/ScadaLTS-patches
RUN \
  git apply /usr/local/src/ScadaLTS-patches/00-refactor-http-publisher.diff \
  && git apply /usr/local/src/ScadaLTS-patches/10-create-json-publisher.diff
#
# BUILD
#
FROM debian:10.9 AS build
WORKDIR /usr/local/src
## Install deps
RUN apt-get update -qq && apt-get install -y \
  nodejs \
  npm \
  wget \
  openjdk-11-jdk-headless
## ANT
ARG ANT_VERSION=1.10.11
RUN wget -O - https://downloads.apache.org//ant/binaries/apache-ant-${ANT_VERSION}-bin.tar.gz | tar -xzf - \
  && ln -sf /usr/local/src/apache-ant-${ANT_VERSION} /opt/apache-ant
## ANT
ARG TOMCAT_VERSION=7.0.109
RUN wget -O - https://archive.apache.org/dist/tomcat/tomcat-7/v${TOMCAT_VERSION}/bin/apache-tomcat-${TOMCAT_VERSION}.tar.gz | tar -xzf - \
  && ln -sf /usr/local/src/apache-tomcat-${TOMCAT_VERSION} /opt/apache-tomcat7
ENV CATALINA_HOME=/opt/apache-tomcat7
## Build
COPY --from=scadalts-source /usr/local/src/Scada-LTS /usr/local/src/Scada-LTS/
ENV ANT_OPTS=-Dfile.encoding=utf-8
WORKDIR /usr/local/src/Scada-LTS
### Fix /usr/local/src/Scada-LTS/build.xml:414: /usr/local/src/Scada-LTS/scadalts-ui/dist/img does not exist
RUN mkdir -p /usr/local/src/Scada-LTS/scadalts-ui/dist/img
RUN /opt/apache-ant/bin/ant -lib lib/ war
#
# RUN
#
FROM tomcat:9.0.46-jdk16-openjdk-slim-buster AS run
# Healthcheck
RUN apt-get update -qq && apt-get install -y curl wait-for-it
WORKDIR /usr/local/tomcat/
# ScadaLTS
COPY --from=build /usr/local/src/Scada-LTS/WebContent/WEB-INF/lib/mysql-connector-java-3.1.8-bin.jar  /usr/local/tomcat/lib
COPY --from=build /usr/local/src/Scada-LTS/WebContent/WEB-INF/lib/mysql-connector-java-5.1.38-bin.jar /usr/local/tomcat/lib
COPY --from=build /usr/local/src/Scada-LTS/WebContent/WEB-INF/lib/mysql-connector-java-5.1.7-bin.jar  /usr/local/tomcat/lib

WORKDIR /usr/local/tomcat/webapps/
RUN mkdir ScadaLTS

WORKDIR /usr/local/tomcat/webapps/ScadaLTS
COPY --from=build /usr/local/src/Scada-LTS/ScadaBR.war /usr/local/tomcat/webapps/ScadaLTS/ScadaLTS.war
RUN jar -xvf ScadaLTS.war && rm ScadaLTS.war
WORKDIR /usr/local/tomcat/
# Camunda
COPY --from=camunda /camunda/conf/bpm-platform.xml /usr/local/tomcat/conf/bpm-platform.xml
COPY --from=camunda /camunda/lib/*.jar /usr/local/tomcat/lib/
COPY --from=camunda /camunda/webapps/camunda /usr/local/tomcat/webapps/camunda/
COPY --from=camunda /camunda/webapps/camunda-welcome /usr/local/tomcat/webapps/camunda-welcome
COPY --from=camunda /camunda/webapps/engine-rest /usr/local/tomcat/webapps/engine-rest
# Entrypoint
ADD context.xml /usr/local/tomcat/conf/
ADD server.xml /usr/local/tomcat/conf/
ADD entrypoint.sh /usr/local/bin
RUN chmod +x /usr/local/bin/entrypoint.sh
ENTRYPOINT [ "/usr/local/bin/entrypoint.sh" ]
