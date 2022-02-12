#!/bin/sh
if [ -n "$ACCEPT_RANGE" ]; then
    exec socat \
        "tcp-listen:1337,range=${ACCEPT_RANGE},fork" \
        unix-connect:/var/run/docker.sock
else
    exec socat \
        tcp-listen:1337,fork \
        unix-connect:/var/run/docker.sock
fi
