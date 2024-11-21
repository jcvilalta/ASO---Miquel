#!/bin/sh

# Creem el grup de seguretat
aws ec2 create-security-group --group-name sg-hackaton --description "Security group pel Hackaton" > /dev/null 2>&1

# Obtenim el codi de sortida
CODIERROR=$?

# Guardem la ID del grup per accions posteriors
ID=$(echo $(aws ec2 describe-security-groups --filter Name=group-name,Values="sg-hackaton" --query 'SecurityGroups[0].[GroupId]' --output text))

