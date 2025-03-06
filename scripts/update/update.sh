#!/bin/bash

# Paràmetres per cridad l'script de backups
DIR_ORIGEN="/home/xukim/work/ASO---Miquel" # Es pot modificar per si en volem un altre per defecte

# Executar l'script de backups
/home/xukim/work/ASO---Miquel/scripts/backups/backup.sh "$DIR_ORIGEN"

# Commprovar si l'script de backups ha funcionat
if [ $? -eq 0 ]; then
	echo "Backup creat correctament. Procedim amb l'actualització del sistema..."

	# Actualitzar el sistema
	sudo apt update && sudo apt upgrade -y

	if [ $? -eq 0 ]; then
        	echo "Sistema actualitzat correctament."
	else
	echo "Error en l'actualització del sistema."
	fi
else
	echo "Error en la còpia de seguretat. L'actualització no es realitzarà."
fi
