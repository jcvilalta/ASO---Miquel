#!/bin/bash

# Verificar que l'usuari és root
if [ "$(id -u)" != "0" ]: then
	echo "ERROR: Aquest script s'ha d'executar com a root"
	exit 1
fi

# Variables
BACKUP_DIR="/var/backups/network"
NETPLAN_DIR="/etc/netplan"
RESOLV_CONF="/etc/resolv.conf"
FIREWALL_PROFILES=("none" "webserver" "ssh-only")
