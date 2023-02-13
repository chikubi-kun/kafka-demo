#!/bin/bash

# waits for tcp ports to be open.
# $1: expects the hosts and port in array form: localhost:9092,localhost:9093

wait_for() {
    IFS=','; for i in $1; do
        host="$(echo "$i" | cut -d':' -f1)"
        port="$(echo "$i" | cut -d':' -f2)"
        while !  $(nc -z -v -w5 $host $port); do
            echo "Waiting for '$i' to come up..."
            sleep 5
        done
        echo "$i is up. Continuing."
    done
}

if [ -z $1 ]; then
    echo "no arguments given. Please add them in comma separated array form 'host:port,host2:port2'"
    exit 1
fi

wait_for "$1";

echo "All dependencies are up. Ready!"