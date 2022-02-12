#
# Build
#
FROM maven:3.8.1-openjdk-16 AS build
# Copy POM
RUN mkdir -p /opt/scriptablesensor
ADD pom.xml /opt/scriptablesensor
# Download dependencies
WORKDIR /opt/scriptablesensor
RUN mvn dependency:resolve dependency:resolve-plugins dependency:go-offline
# Create JAR
COPY src /opt/scriptablesensor/src
RUN mvn package
#
# Run
#
FROM openjdk:16
COPY --from=build /opt/scriptablesensor/target/scriptablesensor-*.jar /opt/scriptablesensor.jar
WORKDIR /opt
ENTRYPOINT [ "java","--illegal-access=permit","-jar", "/opt/scriptablesensor.jar" ]