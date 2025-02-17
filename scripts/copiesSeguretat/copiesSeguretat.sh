#!/bin/bash

# Dir origen i dir destí
DIR_ORIGEN="/home/xukim/Documents"
DIR_DESTI="/home/xukim/copies"

# Data actual (per incloure al nom de la còpia)
DATA=$(date +'%d-%m-%Y_%H-%M-%S')

# Nom fitxer còpia
FITXER_COPIA="còpia_$DATA.tar.gz"

# Demanem confirmació per crear la còpia

read -p "Estàs segur que vols crear una còpia de seguretat? (s/n): " CONFIRMAR

if [[ "$CONFIRMAR" == "s" || "$CONFIRMAR" == "S" ]]; then
	# Crear còpia compressa
	tar -czf "$DIR_DESTI/$FITXER_COPIA" -C "$DIR_ORIGEN" .

	# Comprovem si la còpia s'ha creat correctament
	if [[ -f "$DIR_DESTI/$FITXER_COPIA" ]]; then
		echo "La còpia de seguretat ha sigut creada amb èxit: $DIR_DESTI/$FITXER_COPIA"
	else
		echo "Hi ha hagut un problema en crear la còpia de seguretat."
	fi
else
	echo "Còpia de seguretat no creada."
fi
