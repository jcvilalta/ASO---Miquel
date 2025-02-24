#!/bin/bash

# Comprovar si s'ha introduid un PID
if [ -z "$1" ]; then
	echo "Ús: $0 <PID>"
	exit 1
fi

PID=$1

# Executar top per obtenir l'ús de la CPU del procés
US_CPU=$(top -b -n 1 -p $PID | awk 'NR>7 {print $9}')

# Comprovar si el valor obtingut és vàlid
if [ -z "$US_CPU" ]; then
	echo "No s'ha pogut obtenir l'ús de CPU. Assegura't que el procés amb PID $PID existeix."
	exit 1
fi

echo "El procés $PID està utilitzant un $US_CPU% de la CPU."
