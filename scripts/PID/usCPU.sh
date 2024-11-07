#!/bin/bash

# Aquest script serveix per veure el % d'ús de la CPU

PID=$1

TEMPSCPU=$(ps -p $PID -o etime=,cputime=)
ETIME=$(ps -p $PID -o etime)
CPUTIME=$(ps -p $PID -o cputime)

echo "$TEMPSCPU"
echo "$ETIME"
echo "CPUTIME"

USCPU= let $CPUTIME*100 / $ETIME

echo "USCPU"
