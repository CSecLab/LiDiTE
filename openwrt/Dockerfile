#
# Download OpenWRT
#
FROM busybox AS download

ARG SCHEMA=https
ARG MIRROR=downloads.openwrt.org
ARG RELEASE=19.07.7
ARG URL=${SCHEMA}://${MIRROR}/releases/${RELEASE}/targets/x86/64/openwrt-${RELEASE}-x86-64-generic-rootfs.tar.gz

WORKDIR /opt
RUN wget -O - ${URL} | tar -xzvf -

#
# Build OpenWRT
#
FROM scratch
COPY --from=download /opt /

RUN mkdir /var/lock;opkg update;opkg install quagga quagga-bgpd quagga-ospfd quagga-zebra ulogd ulogd-mod-extra ulogd-mod-nflog ulogd-mod-syslog iptables-mod-nflog tcpdump

ADD ulogd.conf /etc/ulogd.conf
ADD entrypoint.sh /usr/local/bin/
RUN /etc/init.d/ulogd enable; chmod a+x /usr/local/bin/entrypoint.sh; rm -Rf /var/lock

ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
#ENTRYPOINT ["/sbin/init"]
