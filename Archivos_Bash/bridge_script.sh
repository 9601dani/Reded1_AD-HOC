#!/bin/bash

IP_ROUTER=$2
INTERFAZ=$3

if [ $1 == "I" ]
then
	ip route add 10.23.0.0/26 via $IP_ROUTER dev $INTERFAZ
	ip route add 10.22.0.0/29 via $IP_ROUTER dev $INTERFAZ
	iptables -t nat -A PREROUTING -d 10.23.0.2 -j DNAT --to-destination $IP_ROUTER
	iptables -t nat -A PREROUTING -d 10.22.0.2 -j DNAT --to-destination $IP_ROUTER

else
	ip route add 10.24.0.0/27 via $IP_ROUTER dev $INTERFAZ
	ip route add 10.25.0.0/29 via $IP_ROUTER dev $INTERFAZ
	iptables -t nat -A PREROUTING -d 10.24.0.2 -j DNAT --to-destination $IP_ROUTER
	iptables -t nat -A PREROUTING -d 10.25.0.2 -j DNAT --to-destination $IP_ROUTER
fi
