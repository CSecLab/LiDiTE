#
# Build
#
FROM maven:3.8.1-openjdk-16 AS build
# Copy POM
RUN mkdir -p /opt/ditto-binpack
ADD pom.xml /opt/ditto-binpack
# Download dependencies
WORKDIR /opt/ditto-binpack
RUN mvn dependency:resolve dependency:resolve-plugins dependency:go-offline
# Create JAR
COPY src /opt/ditto-binpack/src
RUN mvn package
#
# Run
#
FROM openjdk:16
#FROM ghcr.io/graalvm/graalvm-ce:21.0.0
COPY --from=build /opt/ditto-binpack/target/lib /opt/lib
COPY --from=build /opt/ditto-binpack/target/binpack-*.jar /opt/ditto-binpack.jar
WORKDIR /opt
ENTRYPOINT [ "java", "-jar", "/opt/ditto-binpack.jar" ]
