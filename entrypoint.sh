#!/bin/bash

cd /root/src/hello

while :
do
    ./build.sh
    service nginx restart

    sleep 5
done


