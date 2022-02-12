FROM debian:10.9
RUN apt-get update -qq && apt-get install -y bind9
ENTRYPOINT [ "/usr/sbin/named", "-c", "/etc/bind/named.conf", "-f", "-u", "bind" ]
