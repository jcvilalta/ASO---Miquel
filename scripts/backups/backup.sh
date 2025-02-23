	#!/bin/bash
# còpia DIRECTORI [ELIMINAR=N]

# Directori on es guardaran les còpies
DIR_DESTI="/home/xukim/copies"

# Fitxer de logs
FITXER_LOG="/var/log/scriptsErrors/backups/backup.log"

# Directori origen (del qual es fa la còpia)
DIR_ORIGEN="$1"

# Paràmetre ELIMINAR (per a còpies antigues)
ELIMINAR="$2"

# Crear el directori de logs si no existeix
mkdir -p "$(dirname "$FITXER_LOG")"

# Comprovar permisos d'escriptura al fitxer de log
if [ -e "$FITXER_LOG" ] && [ ! -w "$FITXER_LOG" ]; then
    echo "Error: No tens permisos d'escriptura al fitxer de log '$FITXER_LOG'."
    exit 5
fi

# Funció per escriure al log
log_message() {
    echo "$(date +%Y-%m-%d\ %H:%M:%S) - $1" | tee -a "$FITXER_LOG"
}

# Comprovar que s'ha passat almenys un argument
if [ -z "$DIR_ORIGEN" ]; then
    log_message "Error: No s'ha passat el directori d'origen."
    echo "Ús: $(basename "$0") <directori_origen> [ELIMINAR=N]" | tee -a "$FITXER_LOG"
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

# Comprovar si s'ha passat ELIMINAR
if [ "$ELIMINAR" = "Y" ]; then
	find "$DIR_DESTI" -type f -name "copia_$(basename "$DIR_ORIGEN")_*" -mtime +7 -exec rm -f {} \;
	log_message "Còpies antigues de més de 7 dies eliminades."
fi
