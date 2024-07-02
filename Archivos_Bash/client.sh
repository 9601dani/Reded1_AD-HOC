#!/bin/bash

INTERFAZ=$2

if [ $1 == "A" ]
then

	ip addr add 10.22.0.2/29 dev $INTERFAZ
	ip link set $INTERFAZ up

	ip route add default via 10.22.0.1 dev $INTERFAZ

elif [ $1 == "B" ]
then

	ip addr add 10.23.0.2/26 dev $INTERFAZ
	ip link set $INTERFAZ up

	ip route add default via 10.23.0.1 dev $INTERFAZ

elif [ $1 == "C" ]
then

	ip addr add 10.24.0.2/27 dev $INTERFAZ
	ip link set $INTERFAZ up

	ip route add default via 10.24.0.1 dev $INTERFAZ

elif [ $1 == "D" ]
then
	ip addr add 10.25.0.2/29 dev $INTERFAZ
	ip link set $INTERFAZ up

	ip route add default via 10.25.0.1 dev $INTERFAZ
fi



