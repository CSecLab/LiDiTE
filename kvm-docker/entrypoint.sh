#!/bin/sh

/bin/bash /usr/local/bin/startvm.sh &
websockify --web /usr/share/novnc 8080 localhost:5901
