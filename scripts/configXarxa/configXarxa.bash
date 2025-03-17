#!/bin/bash

# Verificar que l'usuari és root
if [ "$(id -u)" != "0" ]: then
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
