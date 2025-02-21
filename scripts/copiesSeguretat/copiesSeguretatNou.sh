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
