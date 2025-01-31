#!/bin/bash

INTERFAZ_INTERNA=$2
INTERFAZ_OTRO_ROUTER=$3
INTERFAZ_PUENTE=$4

sysctl -w net.ipv4.ip_forward=1

if [ $1 == "B" ]
then

	# ASIGNAMOS LA IP DE LA RED INTERNA A LA INTERFAZ Y LEVANTAMOS
	ip addr add 10.23.0.1/26 dev $INTERFAZ_INTERNA
	ip link set $INTERFAZ_INTERNA up

	# ASIGNAMOS LA IP CON LA QUE SE CONECTARÁ B CON A
	ip addr add 10.32.0.2/30 dev $INTERFAZ_OTRO_ROUTER
	ip link set $INTERFAZ_OTRO_ROUTER up

	# REDIRECCIONAMOS EL TRÁFICO RELACIONADO CON A A SU IP PÚBLICA
	ip route add 10.22.0.0/29 via 10.32.0.1 dev $INTERFAZ_OTRO_ROUTER

	# REDIRECCIONAMOS TODO EL DEMÁS TRÁFICO HACIA EL PUENTE
	ip route add default via 10.42.0.1 dev $INTERFAZ_PUENTE

elif [ $1 == "C" ]
then

	# ASIGNAMOS LA IP DE LA RED INTERNA A LA INTERFAZ Y LEVANTAMOS
	ip addr add 10.24.0.1/27 dev $INTERFAZ_INTERNA
	ip link set $INTERFAZ_INTERNA up

	# ASIGNAMOS LA IP CON LA QUE SE CONECTARÁ C A D
	ip addr add 10.35.0.1/30 dev $INTERFAZ_OTRO_ROUTER
	ip link set $INTERFAZ_OTRO_ROUTER up

	# REDIRECCIONAMOS EL TRÁFICO RELACIONADO CON D A SU IP PÚBLICA
	ip route add 10.25.0.0/29 via 10.35.0.2 dev $INTERFAZ_OTRO_ROUTER

	# REDIRECCIONAMOS TODO EL DEMÁS TRÁFICO HACIA EL PUENTE
	ip route add default via 10.42.0.1 dev $INTERFAZ_PUENTE

fi

# CONFIGURAMOS LA TABLA NAT PARA ENMASCARAR EL PAQUETE LUEGO DE ENRUTARLO
# AL PUENTE PERO ANTES DE ENVIARLO
iptables -t nat -A POSTROUTING -o $INTERFAZ_PUENTE -j MASQUERADE

