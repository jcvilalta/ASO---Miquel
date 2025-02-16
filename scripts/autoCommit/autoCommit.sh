#!/bin/bash

MISSATGE="$1"
RUTA="/home/xukim/work/jcvilalta/scripts"

git add $RUTA
git commit -m "$MISSATGE"
git push origin main
