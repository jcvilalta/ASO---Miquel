#!/bin/bash

# Verificar que l'usuari és root
if [ "$(id -u)" != "0" ]; then
	echo "ERROR: Aquest script s'ha d'executar com a root"
	exit 1
fi

# Variables
BACKUP_DIR="/var/backups/xarxa"
TIMESTAMP=$(date +%Y-%m-%d_%H-%M-%S)
BACKUP_PATH="$BACKUP_DIR/$TIMESTAMP"
NETPLAN_DIR="/etc/netplan"
RESOLV_CONF="/etc/resolv.conf"
FIREWALL_PROFILES=("none" "webserver" "ssh-only")

main() {
	process_args "$@"
	do_backup
	conf_xarxa
	tests_xarxa
	echo "Configuració de xarxa aplicada correctament"
}

process_args() {
	while [[ $# -gt 0 ]]; do
		case $1 in
		    --interface)
			INTERFACE="$2"
			shift 2
			;;
		    --dhcp)
			DHCP=true
			shift
			;;
		    --ip)
			IP="$2"
			valid_ip "$IP"
			shift 2
			;;
		    --netmask)
			NETMASK="$2"
			shift 2
			;;
		    --gateway)
			GATEWAY="$2"
			valid_ip "$GATEWAY"
			shift 2
			;;
		    --dns)
			DNS="$2"
			valid_ip "$DNS"
			shift 2
			;;
		    --backup)
			do_backup
			exit 0
			;;
		    --restore)
			restore_backup
			exit 0
			;;
		    --help)
			show_help
			exit 0
			;;
		    *)
			echo "ERROR: Opció desconeguda: $1"
			show_help
			exit 1
			;;
		esac
	done

	# Validacions post-arguments
    	if [ -z "$INTERFACE" ]; then
        	echo "ERROR: Cal especificar --interface"
        	exit 1
    	fi

	if [ -z "$DHCP" ]; then
		if [ -z "$IP" ] || [ -z "$NETMASK" ] || [ -z "$GATEWAY" ]; then
		echo "ERROR: Mode estàtic requereix --ip, --netmask i --gateway"
		exit 1
		fi
	fi
}

# Funció de validació d'IP
valid_ip() {
	local ip=$1
	if [[ ! $ip =~ ^[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}$ ]]; then
		echo "ERROR: El format IP no és vàlid: $ip"
		exit 1
	fi
}


# Funció per crear backups de la configuració de xarxa
do_backup() {
	echo "Fent backup de la configuració actual..."

	# Crear directori siu no existeix
	mkdir -p "$BACKUP_PATH" || {
		echo "ERROR: No s'ha pogut crear el directori de backup"
		exit 1
	}

	# Copiar fitxers importants
	cp /etc/network/interfaces "$BACKUP_PATH/" 2>/dev/null
	cp /etc/resolv.conf "$BACKUP_PATH/" 2>/dev/null
	cp /etc/netplan/*.yaml "$BACKUP_PATH/" 2>/dev/null

	echo "Backup guardat a: $BACKUP_PATH"
}

# Funció per restaurar backups
restore_backup() {
	echo "Restaurant últim backup..."

	# Trobar l'últim backup
	LAST_BACKUP=$(ls -td "$BACKUP_DIR"/*/ | head -1)

	if [ -z "$LAST_BACKUP" ]; then
		echo "ERROR: No hi ha backups disponibles"
		exit 1
	fi

	# Restaurar fitxers
    cp "$LAST_BACKUP/interfaces" /etc/network/ 2>/dev/null
    cp "$LAST_BACKUP/resolv.conf" /etc/ 2>/dev/null
    cp "$LAST_BACKUP"/*.yaml /etc/netplan/ 2>/dev/null

	echo "Backup restaurat correctament. Reinicia el servei de xarxa."
}

# Prova manual (executar amb --backup o --restore)
if [ "$1" == "--backup" ]; then
    do_backup
elif [ "$1" == "--restore" ]; then
    restore_backup
else
    echo "Ús: $0 [--backup|--restore]"
fi
