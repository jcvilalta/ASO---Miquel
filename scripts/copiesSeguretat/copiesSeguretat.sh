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

# Demanem confirmació per crear la còpia

read -p "Estàs segur que vols crear una còpia de seguretat? (s/n): " CONFIRMAR

if [[ "$CONFIRMAR" == "s" || "$CONFIRMAR" == "S" ]]; then
	# Crear còpia compressa
	tar -czf "$DIR_DESTI/$FITXER_COPIA" -C "$DIR_ORIGEN" .

	# Comprovem si la còpia s'ha creat correctament
	if [[ -f "$DIR_DESTI/$FITXER_COPIA" ]]; then
		echo "La còpia de seguretat ha sigut creada amb èxit: $DIR_DESTI/$FITXER_COPIA"
		# Afegir als logs
                echo "$DATA - Còpia creada: $DIR_DESTI/$FITXER_COPIA" >> "$LOGS"
	else
		echo "Hi ha hagut un problema en crear la còpia de seguretat."
		# Afegir als logs
		echo "$DATA - ERROR: No s'ha pogut crear la còpia." >> "$LOGS"
	fi
else
	echo "Còpia de seguretat no creada."
	# Afegir als logs
	echo "$DATA - Còpia no creada (cancel·lat per l'usuari)." >> "$LOGS"
fi

# Funció per eliminar còpies antigues (més de 7 dies)
eliminar_copies_anitgues() {
	echo "$DATA - Comprovant còpies antigues..." >> "$LOGS"

	# Buscar i eliminar arxius més antics de 7 dies
	find "$DIR_DESTI" -type f -name "còpia_*.tar.gz" -mtime +7 -print -delete >> "$LOGS" 2>&1

	echo "$DATA - Còpies antigues eliminades (si n'hi havia)." >> "$LOGS"
}

# Executar la funció un cop creada la còpia
eliminar_copies_antigues
