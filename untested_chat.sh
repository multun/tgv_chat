#!/bin/bash

cd "$(dirname "$0")"
. ./common.sh

check_root

prompt_username

# 253 is reserved for experimentation and testing
ip_proto_num=253

socat_local='-'
socat_remote="IP4-DATAGRAM:255.255.255.255:${ip_proto_num},broadcast"

server () {
    socat "${socat_local}" "${socat_remote}"
}

client_prompt | server | escape_filter
