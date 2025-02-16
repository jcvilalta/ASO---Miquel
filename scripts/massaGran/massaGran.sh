#!/bin/bash

# Comprovar que es passin dos arguments
if [ $# -ne 2 ]; then
  echo "Ús: $0 MIDA FITXER"
  exit 1
fi

# Assignar arguments a variables
SIZE=$1
FILE=$2
USER=$(whoami)
DATE_HOUR=$(date "+%Y-%m-%d %H:%M:%S")
LOGS="/var/log/scriptsErrors/massaGran.log"
