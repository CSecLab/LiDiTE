FROM python:3-alpine

RUN apk update && apk add --no-cache openvpn openssl
RUN pip install docker
COPY entrypoint.sh /usr/local/bin/
COPY generate.sh /usr/local/bin/
COPY config.py /usr/local/bin/


ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
