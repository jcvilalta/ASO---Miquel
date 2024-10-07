#!/bin/bash

# Aquest script serveix per veure el % d'ús de la CPU

PID=$1

USCPU=$(ps -p $PID -o pid=,etime=etime,cputime=cputime)
echo "$USCPU"
