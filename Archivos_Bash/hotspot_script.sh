#!/bin/bash

IP_PUENTE_IZQUIERDA=$1
IP_PUENTE_DERECHA=$2
# Agregando la via hacia el puente derecho cuando el objetivo es C y D
ip route add 10.24.0.0/27 via $IP_PUENTE_DERECHA dev ap0
ip route add 10.25.0.0/29 via $IP_PUENTE_DERECHA dev ap0

# Agregando la via hacia el puente izquierdo cuando el objetivo es A y B
ip route add 10.22.0.0/26 via $IP_PUENTE_IZQUIERDA dev ap0
ip route add 10.23.0.0/27 via $IP_PUENTE_IZQUIERDA dev ap0
