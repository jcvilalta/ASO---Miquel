#!/bin/bash

# Dir origen i dir destí
DIR_ORIGEN="/home/xukim/Documents"
DIR_DESTI="/home/xukim/copies"

# Data actual (per incloure al nom de la còpia)
DATA=$(date +'%d-%m-%Y')

# Nom fitxer còpia
FITXER_COPIA="còpia_$DATA.tar.gz"

# Craer còpia compressa
tar -czf "$DIR_DESTI/$FITXER_COPIA" -C "$DIR_ORIGEN" .
