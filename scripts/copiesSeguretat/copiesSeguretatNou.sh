#!/bin/bash
# copia DIRECTORI [ELIMINAR=N]

# Directori on es guardaran les còpies
DIR_DESTI="/home/xukim/copies"

# Fitxer de logs
FITXER_LOG="/var/log/scriptsErrors/copiesSeguretat/copies.log"

# Directori origen (del qual es fa la còpia)
DIR_ORIGEN="$1"
