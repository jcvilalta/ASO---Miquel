#!/bin/bash
# copia DIRECTORI [ELIMINAR=N]

# Directori on es guardaran les còpies
DIR_DESTI="/home/xukim/copies"

# Fitxer de logs
FITXER_LOG="/var/log/scriptsErrors/copiesSeguretat/copies.log"

# Directori origen (del qual es fa la còpia)
DIR_ORIGEN="$1"

# Comprovar que s'ha passat almenys un argument
if [ "$#" -lt 1 ]; then
    echo "Ús: $0 <directori_origen> [ELIMINAR=N]" >> "$FITXER_LOG"
    exit 1
fi

# Comprovar que el directori origen existeix
if [ ! -d "$DIR_ORIGEN" ]; then
        echo "Error: El directori '$DIR_ORIGEN' no existeix. " >> "$FITXER_LOG"
        exit 2
fi

# Crear el directori destí si no existeix
mkdir -p "$DIR_DESTI"

# Generar nom de l'arxiu de la còpia
DATA=$(date +%Y%m%d_%H%M%S)
FITXER_COPIA="$DIR_DESTI/copia_$(basename "$DIR_ORIGEN")_$DATA.tar.gz"

# Fer la còpia de seguretat
if tar -czf "$FITXER_COPIA" -C "$(dirname "$DIR_ORIGEN")" "$(basename "$DIR_ORIGEN")" 2>> "$FITXER_LOG"; then
        echo "Còpia de seguretat creada: $FITXER_COPIA" >> "$FITXER_LOG"
else
        echo "Error en crear la còpia de seguretat" >> "$FITXER_LOG"
        exit 3
fi
