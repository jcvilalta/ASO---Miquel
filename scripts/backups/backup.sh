#!/bin/bash
# còpia DIRECTORI [ELIMINAR=N] [DIES=N]

# Ús de l'script
US="Ús: $(basename "$0") <directori_origen> [ELIMINAR=N] [DIES=N]"

# Directori on es guardaran les còpies
DIR_DESTI="/home/xukim/copies"
# Fitxer de logs
FITXER_LOG="/var/log/scriptsErrors/backups/backup.log"
# Directori de logs antics
DIR_LOGS_ANTICS="/home/xukim/copies/logsAntics"
# Mida màxima dels logs (1MB)
MAX_LOG=$((1024 * 1024))

# Directori origen (del qual es fa la còpia)
DIR_ORIGEN="$1"

# Paràmetre ELIMINAR (per a còpies antigues)
ELIMINAR="$2"
DIES="$3"

# Funció per escriure al log
log_message() {
    echo "$(date +%Y-%m-%d\ %H:%M:%S) - $1" | tee -a "$FITXER_LOG"
}

# Funció per a les comprovacions
comprovar() {
    # Comprovar que s'ha passat almenys un argument (el directori origen)
    if [ -z "$DIR_ORIGEN" ]; then
        log_message "Error: No s'ha passat el directori d'origen."
        echo "$US" | tee -a "$FITXER_LOG"
        exit 1
    fi

    # Comprovar si s'ha passat el paràmetre per eliminar còpies antigues
    if [[ "$ELIMINAR" = "-a" ]]; then
        # Si es passa el paràmetre DIES, es fa servir el valor introduit, sinó és per defecte 7 dies
        if [ -z "$DIES" ]; then
            DIES=7
        fi

        echo "Eliminant còpies amb més de $DIES dies d'antiguitat..."

        #Eliminar còpies antigues de més de 7 dies
        find "$DIR_DESTI" -type f -name "*.tar.gz" -mtime +$DIES -exec rm -f {} \; && \
        log_message "Còpies antigues de més de $DIES dies eliminades." || \
        log_message "Error en eliminar còpies antigues."
    fi

    # Comprovar que el directori origen existeix
    if [ ! -d "$DIR_ORIGEN" ]; then
        log_message "Error: El directori '$DIR_ORIGEN' no existeix."
        exit 2
    fi

    # Comprovar permisos d'escriptura al fitxer de log
    if [ -e "$FITXER_LOG" ] && [ ! -w "$FITXER_LOG" ]; then
        echo "Error: No tens permisos d'escriptura al fitxer de log '$FITXER_LOG'."
        exit 5
    fi

    # Comprovar permisos d'escriptura al directori de destí
    if [ ! -w "$DIR_DESTI" ]; then
        log_message "Error: No tens permisos d'escriptura al directori de destí '$DIR_DESTI'."
        exit 4
    fi
}

# Crear el directori de logs si no existeix
mkdir -p "$(dirname "$FITXER_LOG")"

# Funció per la rotació de logs si superem la mida màxima
rotar_log() {
    if [ -e "$FITXER_LOG" ] && [ $(stat -c %s "$FITXER_LOG") -ge $MAX_LOG ]; then
        DATA=$(date +%Y%m%d_%H%M%S)
        mv "$FITXER_LOG" "$DIR_LOGS_ANTICS/backup_$DATA.log"
        touch "$FITXER_LOG"
        log_message "S'ha rotat el fitxer de log."
    fi
}

# Crear el directori destí si no existeix
mkdir -p "$DIR_DESTI"

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
