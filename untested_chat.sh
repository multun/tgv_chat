#!/bin/bash

# 253 is reserved for experimentation and testing
ip_proto_num=253

if [[ $UID != 0 ]]; then
    echo >&2 "Must run as root"
    exit 1
fi

while true; do
    read -p 'Enter your username: ' username
    if [[ -n "$username" ]]; then
        break
    fi
done

socat_local='-'
socat_remote="IP4-DATAGRAM:255.255.255.255:${ip_proto_num},broadcast"

server () {
    socat "${socat_local}" "${socat_remote}"
}

escape_filter () {
     sed 's/[\x01-\x1F\x7F]//g'
}

while IFS='', read msg; do
    echo "<$username> $msg"
done | server | escape_filter
