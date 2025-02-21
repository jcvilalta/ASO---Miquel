#!/bin/bash
# còpia DIRECTORI [ELIMINAR=N]

# Directori on es guardaran les còpies
DIR_DESTI="/home/xukim/copies"

# Fitxer de logs
FITXER_LOG="/var/log/scriptsErrors/backups/backup.log"

# Directori origen (del qual es fa la còpia)
DIR_ORIGEN="$1"

# Funció per escriure al log
log_message() {
    echo "$(date +%Y-%m-%d\ %H:%M:%S) - $1" >> "$FITXER_LOG"
}

# Comprovar que s'ha passat almenys un argument
if [ -z "$DIR_ORIGEN" ]; then
    log_message "Error: No s'ha passat el directori d'origen."
    echo "Ús: $0 <directori_origen> [ELIMINAR=N]" >> "$FITXER_LOG"
    exit 1
fi

# Comprovar que el directori origen existeix
if [ ! -d "$DIR_ORIGEN" ]; then
    log_message "Error: El directori '$DIR_ORIGEN' no existeix."
    exit 2
fi

# Comprovar permisos d'escriptura al directori de destí
if [ ! -w "$DIR_DESTI" ]; then
    log_message "Error: No tens permisos d'escriptura al directori de destí '$DIR_DESTI'."
    exit 4
fi

# Crear el directori destí si no existeix
mkdir -p "$DIR_DESTI"

# Generar nom de l'arxiu de la còpia
DATA=$(date +%Y%m%d_%H%M%S)
FITXER_COPIA="$DIR_DESTI/copia_$(basename "$DIR_ORIGEN")_$DATA.tar.gz"

# Fer la còpia de seguretat
if tar -czf "$FITXER_COPIA" -C "$(dirname "$DIR_ORIGEN")" "$(basename "$DIR_ORIGEN")" 2>> "$FITXER_LOG"; then
    log_message "Còpia de seguretat creada: $FITXER_COPIA"
else
    log_message "Error en crear la còpia de seguretat"
    exit 3
fi
