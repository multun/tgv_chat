#!/bin/bash

cd "$(dirname "$0")"
. ./common.sh

check_root

# 67 some port used by bootp, unfiltered here
udp_port=67

socat_local='-'
socat_remote="UDP-DATAGRAM:255.255.255.255:${udp_port},broadcast"

client_sender () {
    socat "${socat_local}" "${socat_remote}"
}

stop_hook () {
    [[ -z "${server_pid}" ]] || {
        kill -9 "${server_pid}"
        wait "${server_pid}" || :
    }
}

trap stop_hook EXIT

./dhcp_chat_server "${udp_port}" &
server_pid=$?

stdbuf -o 0 ./sharp_prompt.sh | client_sender
