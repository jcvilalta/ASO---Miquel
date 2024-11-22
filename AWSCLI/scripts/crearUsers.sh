#!/bin/sh

USUARI=$1
PASSWD=$2

useradd $USUARI
usermod --password $(echo $PASSWD | openssl passwd -1 -stdin) $USUARI
