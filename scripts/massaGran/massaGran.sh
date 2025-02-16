#!/bin/bash

# Comprovar que es passin dos arguments
if [ $# -ne 2 ]; then
  echo "Ús correcte: $0 <mida (KB)> <fitxer>"
  exit 1
fi

# Assignació variables
FILE_SIZE=$1		# Mida en KB
FILE=$2		# Nom fitxer
USER=$(whoami)	# Usuari actual
DATE_HOUR=$(date "+%Y-%m-%d %H:%M:%S")	# Data i hora actuals
LOGS="/var/log/scriptsErrors/massaGran/massaGran.log"	# Ruta fitxer de logs

# Comprovar l'existència del fitxer
if [ ! -f "$FILE" ]; then
	echo "$DATE_HOUR - Usuari: $USER - ERROR: $FILE no existeix." >>  "$LOGS"
	exit 1
fi

# Calcular mida del fitxer (KB)
FILE_SIZE_KB=$(du -k "$FILE" | cut -f1)

# Comprovar la mida del fitxer
if [ $FILE_SIZE_KB -gt $FILE_SIZE ]; then
	DIFFERENCE=$((FILE_SIZE_KB - FILE_SIZE))
	echo "$DATE_HOUR - ALERTA: El fitxer $FILE és més gran que $FILE_SIZE kB (Diferència: $DIFFERENCE kB). Usuari: $USER" >> "$LOGS"
fi
