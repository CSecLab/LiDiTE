#!/bin/sh

test -n $DAYS || DAYS='3650'
test -n $PASS || PASS='changeme'
test -n $SUBJECT || SUBJECT='/C=IT/L=Genoa/O=FDT/CN'
test -n $SIZE || SIZE='2048'

test -f /etc/openvpn/ca.key && exit

cd /etc/openvpn

openssl req -nodes -newkey rsa:$SIZE -subj "$SUBJECT=ca" -new -x509 -days $DAYS -keyout ca.key -out ca.cert 

openssl req -nodes -newkey rsa:$SIZE -keyout server.key -subj "$SUBJECT=server" -out server.csr

openssl x509 -days $DAYS -req -in server.csr -CA ca.cert -CAkey ca.key -set_serial 10 -out server.cert

openssl req -nodes -newkey rsa:$SIZE -keyout client.key -subj "$SUBJECT=client" -out client.csr

openssl x509 -days $DAYS -req -in client.csr -CA ca.cert -CAkey ca.key -set_serial 10 -out client.cert

test -f dh.pem || openssl dhparam -out dh.pem $SIZE

rm -f client.csr server.csr

exit