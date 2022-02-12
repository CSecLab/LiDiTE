#
# KVM
#
FROM bitnami/minideb:buster
RUN apt-get update &&  \
    apt-get install -y qemu-kvm socat screen dnsmasq iptables iproute2 netcat telnet expect vim-tiny ssh
#
# Visual
#
RUN apt-get update && \
    apt-get install -y websockify novnc tini
COPY entrypoint.sh /usr/local/bin/entrypoint
RUN chmod +x /usr/local/bin/entrypoint \
 && ln -sf /usr/local/bin/entrypoint /entrypoint
ADD startvm.sh /usr/local/bin/
ENTRYPOINT [ "/usr/bin/tini" ,"/entrypoint" ]
