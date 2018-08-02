There are two implementations here: one was tested and is known to work,
the other remains untested until me or somebody else can test it :)

There basically are a couple of wifi routers forwarding packets to a big
NAT / login portal thing, which also does DHCP. However, anybody could
broadcast something that looks like DHCP packets and everybody receives it.

The other method I couldn't test relies on raw broadcasting raw IP packets,
which hopefuly wouldn't be filtered either.

# Deps

```
socat
bash
gcc
```

# Usage

```
./untested_chat.sh

# or
make dhcp_chat_server
./chat.sh
```

# What if it doesn't work anymore

Unless they implement proper DHCP snooping, there are quite many things one
could do to pass around messages, such sending an echo packet to the gate from
some machine A, spoofing some random source mac. While the gate is processing
the message, another machine, B, sends some random packet to the gate using the
same source mac as the one A used. Guess what, the answer of the gate would be
reflected to B because the ARP tables and switches port mappings were changed as
B's messaged was passed along.

That's indeed some quite tight timing, hopefuly that'll never be needed

# Wait, that DHCP thing sounds bad

Yeah. Go figure out why by yourself :)

# Why not using the chat from wifi.sncf ?

¯\_(ツ)_/¯
