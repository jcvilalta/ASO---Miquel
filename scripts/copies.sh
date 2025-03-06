#!/bin/bash
# còpia DIRECTORI [ELIMINAR=N] [DIES=N]

# Ús de l'script
US="Ús: $(basename "$0") <directori_origen> [ELIMINAR=N] [DIES=N]"

# Directori on es guardaran les còpies
DIR_DESTI="/home/xukim/copies"
# Directori on es guardaran els logs antics
DIR_LOGS_ANTICS="/home/xukim/copies/logsAntics"
# Fitxer de logs
FITXER_LOG="/var/log/scriptsErrors/backups/backup.log"
# Mida màxima del log en bytes (1 MB)
MIDA_MAX_LOG=$((1024 * 1024))

# Crear el directori de logs si no existeix
mkdir -p "$(dirname "$FITXER_LOG")" "$DIR_LOGS_ANTICS"

# Funció per escriure al log
log_message() {
    echo "$(date +%Y-%m-%d\ %H:%M:%S) - $1" | tee -a "$FITXER_LOG"
}

# Funció per rotar el log si supera la mida màxima
rotar_log() {
    if [ -e "$FITXER_LOG" ] && [ $(stat -c %s "$FITXER_LOG") -ge $MIDA_MAX_LOG ]; then
        DATA=$(date +%Y%m%d_%H%M%S)
        mv "$FITXER_LOG" "$DIR_LOGS_ANTICS/backup_$DATA.log"
        touch "$FITXER_LOG"
        log_message "S'ha rotat el fitxer de log."
    fi
}

# Directori origen (del qual es fa la còpia)
DIR_ORIGEN="$1"
# Paràmetre ELIMINAR (per a còpies antigues)
ELIMINAR="$2"
DIES="$3"

# Comprovar que s'ha passat almenys un argument
if [ -z "$DIR_ORIGEN" ]; then
    log_message "Error: No s'ha passat el directori d'origen."
    echo "$US" | tee -a "$FITXER_LOG"
    exit 1
fi

# Comprovar que el directori origen existeix
if [ ! -d "$DIR_ORIGEN" ]; then
    log_message "Error: El directori '$DIR_ORIGEN' no existeix."
    exit 2
fi

# Crear el directori destí si no existeix
mkdir -p "$DIR_DESTI"

# Comprovar permisos d'escriptura al directori de destí
if [ ! -w "$DIR_DESTI" ]; then
    log_message "Error: No tens permisos d'escriptura al directori de destí '$DIR_DESTI'."
    exit 4
fi

# Comprovar permisos d'escriptura al fitxer de log
if [ -e "$FITXER_LOG" ] && [ ! -w "$FITXER_LOG" ]; then
    echo "Error: No tens permisos d'escriptura al fitxer de log '$FITXER_LOG'."
    exit 5
fi

# Rotar el log abans de començar la còpia de seguretat
rotar_log

# Generar nom de l'arxiu de la còpia
DATA=$(date +%Y%m%d_%H%M%S)
FITXER_COPIA="copia_$(basename "$DIR_ORIGEN")_$DATA.tar.gz"

# Fer la còpia de seguretat
if tar -czf "$DIR_DESTI/$FITXER_COPIA" -C "$DIR_ORIGEN" . 2>> "$FITXER_LOG"; then
    log_message "Còpia de seguretat creada: $DIR_DESTI/$FITXER_COPIA"
else
    log_message "Error en crear la còpia de seguretat"
    exit 3
fi

# Comprovar si s'ha passat el paràmetre per eliminar còpies antigues
if [[ "$ELIMINAR" = "-a" ]]; then
    if [ -z "$DIES" ]; then
        DIES=7
    fi
    log_message "Eliminant còpies amb més de $DIES dies d'antiguitat..."
    find "$DIR_DESTI" -type f -name "*.tar.gz" -mtime +$DIES -exec rm -f {} \; && \
    log_message "Còpies antigues de més de $DIES dies eliminades." || \
    log_message "Error en eliminar còpies antigues."
fi
