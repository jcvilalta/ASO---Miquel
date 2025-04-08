#!/bin/bash

MISSATGE="$1"
RUTA="/home/jolkin/work/ASO---Miquel/scripts"

git add $RUTA
git commit -m "$MISSATGE"
git push origin main
