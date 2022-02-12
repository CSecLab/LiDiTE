#!/bin/sh

OPT=""
test -z $BASE || OPT="$OPT -b $BASE"
test -z $MAXLOAD || OPT="$OPT -l $MAXLOAD"
test -z $REFRESH || OPT="$OPT -r $REFRESH"
test -u $URL || OPT="$OPT -u $URL"
test -u $ADDRESS || OPT="$OPT --address $ADDRESS"
test -u $PORT || OPT="$OPT --port $PORT"
test -u $VERBOSE || OPT="$OPT --verbose"
test -u $BREAKER || OPT="$OPT --breaker"

if [ -n "$URL" ]; then
    h=$(echo $URL | cut -d/ -f 3 | cut -d: -f 1)
    p=$(echo $URL | cut -d/ -f 3 | cut -d: -f 2)
    echo -n "Waiting $h:$p "
    until $(nc -z $h $p); do
        echo -n '.'
        sleep 5
    done
    echo " done"
    sleep 5
fi

cd src
exec python app.py -i $ID $OPT
