#!/bin/bash

# Comprovar si es passen dos arguments
if [ $# -ne 2 ]; then
  echo "Ús: $0 MIDA FITXER"
  exit 1
fi

# Assignar arguments a variables
MIDA=$1
echo "Mida: $MIDA"

FITXER=$2
echo "Fitxer $FITXER"

# Obtenir la mida del fitxer
MIDAFITXER=$(du -b "$FITXER" | cut -f1)

# Fem la diferència de la mida que hem posat amb la mida del fitxer
let DIF=$MIDAFITXER-$MIDA
echo "Mida del fitxer: $MIDAFITXER"
echo "Diferència: $DIF"

# Comprovar si el fitxer existeix
if [ ! -f "$FITXER" ]; then
  echo "Error: El fitxer '$FITXER' no existeix."
  exit 1
fi

# Comparar la mida del fitxer amb la mida donada
if [ "$MIDAFITXER" -gt "$MIDA" ]; then
  echo "El fitxer '$FITXER' és més gran que $numMida bytes i és $DIF bytes més gran."

fi
