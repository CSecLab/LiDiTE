#!/bin/bash

opened=0

PORT=9999

echo -n "Waiting port $PORT..."

while ! nc -z localhost $PORT; do   
  sleep 0.1 # wait for 1/10 of the second before check again
done

echo "OK"
/scripts/setpass.exp
