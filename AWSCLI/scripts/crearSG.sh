#!/bin/sh

# Creem el grup de seguretat
aws ec2 create-security-group --group-name hackaton-sg --description "Security group pel Hackaton"

# Obtenim el codi de sortida
CODIERROR=$?

# Comprovem errors
if [ $CODIERROR -ne 0 ]; then
	echo "Error: No s'ha pogut crear el grup de seguretat. Codi d'error: $CODIERROR"
	exit 2
fi

# Guardem la ID del grup per accions posteriors
ID=$(aws ec2 describe-security-groups --filter Name=group-name,Values="hackaton-sg" --query 'SecurityGroups[0].[GroupId]' --output text)

# Comprovem si s'ha obtingut la ID
if [ -z "$ID" ]; then
	echo "Error: No s'ha pogut obtenir la ID del SG."
	exit 2
fi

echo "ID del SG: $ID"

# Afegim regles d'entrada
# HTTP (80)
aws ec2 authorize-security-group-ingress --group-id $ID --protocol tcp --port 80 --cidr 0.0.0.0/0
# HTTPS (443)
aws ec2 authorize-security-group-ingress --group-id $ID --protocol tcp --port 443 --cidr 0.0.0.0/0
# SSH (22)
aws ec2 authorize-security-group-ingress --group-id $ID --protocol tcp --port 22 --cidr 0.0.0.0/0
# RDP(3389)
aws ec2 authorize-security-group-ingress --group-id $ID --protocol tcp --port 3389 --cidr 0.0.0.0/0
# DNS (UDP) (53)
aws ec2 authorize-security-group-ingress --group-id $ID --protocol udp --port 53 --cidr 0.0.0.0/0
# DNS (TCP) (53)
aws ec2 authorize-security-group-ingress --group-id $ID --protocol tcp --port 53 --cidr 0.0.0.0/0
# LDAP (389)
aws ec2 authorize-security-group-ingress --group-id $ID --protocol tcp --port 389 --cidr 0.0.0.0/0
# Secure LDAP (636)
aws ec2 authorize-security-group-ingress --group-id $ID --protocol tcp --port 636 --cidr 0.0.0.0/0

