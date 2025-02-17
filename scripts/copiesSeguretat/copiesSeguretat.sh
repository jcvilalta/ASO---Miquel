#!/bin/bash

# Dir origen i dir destí
DIR_ORIGEN="/home/xukim/Documents"
DIR_DESTI="/home/xukim/copies"

# Data actual (per incloure al nom de la còpia)
DATA=$(date +'%d-%m-%Y_%H-%M-%S')

# Nom fitxer còpia
FITXER_COPIA="còpia_$DATA.tar.gz"

# Fitxer de logs
LOGS="/var/log/scriptsErrors/copiesSeguretat/copiesSeguretat.log"
LOGS_ANTIGUES="/var/log/scriptsErrors/copiesSeguretat/copiesAntigues.log"

# Demanem confirmació per crear la còpia

read -p "Estàs segur que vols crear una còpia de seguretat? (s/n): " CONFIRMAR

if [[ "$CONFIRMAR" == "s" || "$CONFIRMAR" == "S" ]]; then
	# Crear còpia compressa
	tar -czf "$DIR_DESTI/$FITXER_COPIA" -C "$DIR_ORIGEN" .

	# Comprovem si la còpia s'ha creat correctament
	if [[ -f "$DIR_DESTI/$FITXER_COPIA" ]]; then
		echo "La còpia de seguretat ha sigut creada amb èxit: $DIR_DESTI/$FITXER_COPIA"
		# Afegir als logs
                echo "[ INFO ]: $DATA - Còpia creada: $DIR_DESTI/$FITXER_COPIA" >> "$LOGS"
	else
		echo "Hi ha hagut un problema en crear la còpia de seguretat."
		# Afegir als logs
		echo "[ ERROR ]: $DATA - No s'ha pogut crear la còpia." >> "$LOGS"
	fi
else
	echo "Còpia de seguretat no creada."
	# Afegir als logs
	echo "[ INFO ]: $DATA - Còpia no creada (cancel·lat per l'usuari)." >> "$LOGS"
fi

# Funció per eliminar còpies antigues
eliminar_copies_antigues() {
    echo "$DATA - Comprovant si hi ha còpies antigues..."

    # Comptar número de còpies antigues
    NUM_COPIES=$(find "$DIR_DESTI" -type f -name "còpia_*.tar.gz" -mtime +7 | wc -l)

    if [[ "$NUM_COPIES" -gt 0 ]]; then
        # Guardar la llista de fitxers antics
        FITXERS_ANTICS=$(find "$DIR_DESTI" -type f -name "còpia_*.tar.gz" -mtime +7)

        # Escriure la llista de fitxers als logs
        echo "[ INFO ]: $DATA - Fitxers a eliminar:" >> "$LOGS_ANTIGUES"
        echo "[ INFO ]: $FITXERS_ANTICS" >> "$LOGS_ANTIGUES"

	# Mostrar llista de fitxers per pantalla
	echo "$DATA - Fitxers a eliminar:"
	echo "$FITXERS_ANTICS"

        # Demanar confirmació per eliminar les còpies antigues
        read -p "Estàs segur que vols eliminar aquestes còpies antigues? (s/n): " CONFIRMAR_ELIMINACIO

        if [[ "$CONFIRMAR_ELIMINACIO" == "s" || "$CONFIRMAR_ELIMINACIO" == "S" ]]; then
            # Eliminar fitxers antics
            echo "$FITXERS_ANTICS" | xargs rm -f

            echo "$DATA - S'han eliminat $NUM_COPIES còpies."
            echo "[ INFO ]: $DATA - Hi havia $NUM_COPIES còpies, han sigut eliminades." >> "$LOGS_ANTIGUES"
        else
            echo "$DATA - No s'han eliminat les còpies antigues."
            echo "[ INFO ]: $DATA - Eliminació cancel·lada per l'usuari." >> "$LOGS_ANTIGUES"
        fi
    else
        echo "$DATA - No hi ha còpies antigues, no esborrem res."
        echo "[ INFO ]: $DATA - No hi havia cap còpia antiga, per tant no s'ha esborrat res" >> "$LOGS_ANTIGUES"
    fi
}

# Executar la funció un cop creada la còpia
eliminar_copies_antigues
