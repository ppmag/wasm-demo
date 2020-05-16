#!/bin/bash

cd /root/src/hello

service nginx restart

while :
do
    ./build.sh
    

    sleep 5
done


