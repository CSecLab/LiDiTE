FROM golang:1.17 AS build
LABEL maintainer="Charlie Lewis <clewis@iqt.org>"
#COPY . /go/src/dovesnap
ARG DOVESNAP_VERSION=8cf7b94
WORKDIR /go/src
RUN git clone https://github.com/IQTLabs/dovesnap.git
WORKDIR /go/src/dovesnap
RUN git checkout ${DOVESNAP_VERSION}
RUN go build -o /out/dovesnap .
FROM debian:bullseye
COPY --from=build /out/dovesnap /
RUN apt-get clean && apt-get update && apt-get install -y --no-install-recommends \
    iptables dbus && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*
RUN update-alternatives --set iptables /usr/sbin/iptables-legacy
RUN apt-get update && apt-get install -y --no-install-recommends \
    ethtool \
    openvswitch-common \
    openvswitch-switch \
    udhcpc && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*
COPY --from=build /go/src/dovesnap/udhcpclog.sh /udhcpclog.sh
ENTRYPOINT ["/dovesnap"]
