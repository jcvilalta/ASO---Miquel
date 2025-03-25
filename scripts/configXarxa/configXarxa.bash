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

conf_xarxa() {
	if [ "DHCP" = true ]; then
		config_dhcp
	else
		config_static
	fi

	if [ -n "$DNS" ]; then
		echo "nameserver" $DNS" > "$RESOLV_CONF"
	fi
}

config_dhcp() {
    if [ -d "$NETPLAN_DIR" ]; then
        cat > "$NETPLAN_DIR/01-dhcp.yaml" << EOF
network:
  version: 2
  renderer: networkd
  ethernets:
    $INTERFACE:
      dhcp4: true
EOF
        netplan apply
    else
        nmcli con mod "$INTERFACE" ipv4.method auto
        nmcli con down "$INTERFACE"
        nmcli con up "$INTERFACE"
    fi
}

config_static() {
    if [ -d "$NETPLAN_DIR" ]; then
        cat > "$NETPLAN_DIR/01-static.yaml" << EOF
network:
  version: 2
  renderer: networkd
  ethernets:
    $INTERFACE:
      addresses: [$IP/$NETMASK]
      routes:
        - to: default
          via: $GATEWAY
EOF
        netplan apply
    else
        nmcli con mod "$INTERFACE" ipv4.method manual \
            ipv4.addresses "$IP/$NETMASK" \
            ipv4.gateway "$GATEWAY"
        nmcli con down "$INTERFACE"
        nmcli con up "$INTERFACE"
    fi
}

# Tests de xarxa
tests_xarxa() {
	echo -e "\nTEST DE CONNECTIVITAT"
	ping -c 2 -W 1 "$GATEWAY" >/dev/null 2>&1 && echo "✓ Connexió local OK" || echo "✗ Error local"
	nslookup google.com >/dev/null 2>&1 && echo "✓ DNS funcionant" || echo "✗ Error DNS"
	ping -c 2 8.8.8.8 >/dev/null 2>&1 && echo "✓ Connexió internet OK" || echo "✗ Sense internet"
}

# Ajuda per l'usuari
show_help() {
	echo "Ús: $0 [OPCIONS]"
	echo "Opcions obligatòries per mode estàtic:"
	echo "  --interface INTERFÍCIE    (ex: eth0)"
	echo "  --ip ADREÇA_IP            (ex: 192.168.1.100)"
	echo "  --netmask MÀSCARA         (ex: 24)"
	echo "  --gateway PORTAD_ENLLAÇ   (ex: 192.168.1.1)"
	echo "Opcions adicionals:"
	echo "  --dns SERVIDOR_DNS        (ex: 8.8.8.8)"
	echo "  --dhcp                    Utilitzar DHCP"
	echo "  --backup                  Fer backup"
	echo "  --restore                 Restaurar backup"
	echo "  --help                    Mostrar ajuda"
}
