#!/bin/bash

# Dir destí
DIR_DESTI="/home/xukim/copies"

# Data actual (per incloure al nom de la còpia)
DATA=$(date +'%d-%m-%Y_%H-%M-%S')

# Nom fitxer còpia
FITXER_COPIA="còpia_$DATA.tar.gz"

# Fitxer de logs
LOGS="/var/log/scriptsErrors/copiesSeguretat/copiesSeguretat.log"
LOGS_ANTIGUES="/var/log/scriptsErrors/copiesSeguretat/copiesAntigues.log"

# Comprovem si el directori d'origen es passa com a paràmetre
if [[ -z "$1" ]]; then
    echo "No s'ha especificat el directori d'origen. Utilitzant el directori actual."
    DIR_ORIGEN="$(pwd)"
else
    DIR_ORIGEN="$1"
fi

# Comprovem si el directori d'origen existeix
if [[ ! -d "$DIR_ORIGEN" ]]; then
    echo "El directori d'origen $DIR_ORIGEN no existeix. Abortant."
    exit 1
fi

# Crear còpia compressa
tar -czf "$DIR_DESTI/$FITXER_COPIA" -C "$DIR_ORIGEN" .

# Comprovem si la còpia s'ha creat correctament
if [[ -f "$DIR_DESTI/$FITXER_COPIA" ]]; then
    echo "La còpia de seguretat de $DIR_ORIGEN ha sigut creada amb èxit: $DIR_DESTI/$FITXER_COPIA"
    # Afegir als logs
    echo "[ INFO ]: $DATA - Còpia creada des de: $DIR_ORIGEN a: $DIR_DESTI/$FITXER_COPIA" >> "$LOGS"
else
    echo "Hi ha hagut un problema en crear la còpia de seguretat."
    # Afegir als logs
    echo "[ ERROR ]: $DATA - No s'ha pogut crear la còpia." >> "$LOGS"
fi

# Funció per eliminar còpies antigues
eliminar_copies_antigues() {
    echo "$DATA - Comprovant si hi ha còpies antigues..."

    # Comptar número de còpies antigues
    NUM_COPIES=$(find "$DIR_DESTI" -type f -name "còpia_*.tar.gz" -mtime +7 | wc -l)

    if [[ "$NUM_COPIES" -gt 0 ]]; then

        # Guardar la llista de fitxers antics
        FITXERS_ANTICS=$(find "$DIR_DESTI" -type f -name "còpia_*.tar.gz" -mtime +7)
        # Afegir el prefix [ INFO ] a cada línia llistada de fitxers antics als logs
        FITXERS_ANTICS_CLASSIFICATS=$(echo "$FITXERS_ANTICS" | sed 's/^\([^\n]*\)$/[ FITXER ]: \1/')

        # Escriure la llista de fitxers als logs
        echo "[ INFO ]: $DATA - Fitxers a eliminar:" >> "$LOGS_ANTIGUES"
        echo "$FITXERS_ANTICS_CLASSIFICATS" >> "$LOGS_ANTIGUES"

        # Mostrar llista de fitxers per pantalla
        echo "$DATA - Fitxers a eliminar:"
        echo "$FITXERS_ANTICS"

        # Eliminar fitxers antics sense confirmació
        echo "$FITXERS_ANTICS" | xargs rm -f

        echo "$DATA - S'han eliminat $NUM_COPIES còpies."
        echo "[ INFO ]: $DATA - Hi havia $NUM_COPIES còpies, han sigut eliminades." >> "$LOGS_ANTIGUES"
    else
        echo "$DATA - No hi ha còpies antigues, no esborrem res."
        echo "[ INFO ]: $DATA - No hi havia cap còpia antiga, per tant no s'ha esborrat res" >> "$LOGS_ANTIGUES"
    fi
}

# Executar la funció per eliminar còpies antigues
eliminar_copies_antigues
