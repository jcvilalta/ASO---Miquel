#!/bin/bash

# Definir el fitxer de logs
FITXER_LOG="/var/log/scriptsErrors/PID/PID.log"

# Funció per escriure al log
log_message() {
    echo "$(date +%Y-%m-%d\ %H:%M:%S) - $1" | tee -a "$FITXER_LOG"
}

# Comprovar si s'ha introduid un PID
if [ -z "$1" ]; then
	log_message "Error: Has d'especificar un PID."
	echo "Ús: $0 <PID>"
	exit 1
fi

PID=$1

# Comprovar si el PID és un número vàlid
if ! [[ "$PID" =~ ^[0-9]+$ ]]; then
	log_message "Error: El PID ha de ser un número."
	exit 1
fi

# Comprovar si `top` està instal·lat
if ! command -v top &> /dev/null; then
	log_message "Error: El comandament 'top' no està instal·lat."
	exit 1
fi

# Executar top per obtenir l'ús de la CPU del procés
US_CPU=$(top -b -n 1 -p $PID | awk 'NR>7 {print $9}')

# Comprovar si el valor obtingut és vàlid
if ! ps -p "$PID" > /dev/null; then
	log_message "Assegura't que el procés amb PID $PID existeix."
	exit 1
fi

echo "El procés $PID està utilitzant un $US_CPU% de la CPU."
