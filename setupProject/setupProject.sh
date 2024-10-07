#!/bin/bash
# Script per crear una estructura de directoris per a empreses i els seus projectes

# $# --> guarda el nº de paràmetres que s'han passat
# $? --> guarda  l'últim error


# Comprovem si s'han proporcionat 2 o 3 paràmetres
if [ $# -ne 2 ] && [ $# -ne 3 ]; then
    echo "Error: Cal passar 2 o 3 paràmetres."
    echo "Ús: $0 <empresa> <projecte> [ruta]"
    exit 1
fi

# Assignem els paràmetres a variables
empresa="$1"
projecte="$2"
ruta="${3:-.}"  # Si no es proporciona ruta, s'utilitza el directori actual


# Configuració de la ruta de treball
PATHSETUP="./"
if [ $# -eq 3 ]; then
    PATHSETUP="$3"
fi

# Crear el directori de logs si no existeix
log_dir="./setupProjectLogs"
mkdir -p "$log_dir"  # Això crea el directori si no existeix

# Intentem accedir al directori especificat per PATHSETUP
cd "$PATHSETUP" 2>/dev/null
if [ $? -ne 0 ]; then
    # Si no es pot accedir, escrivim l'error en un fitxer de registre i sortim
    echo "$(date) $(whoami) ERROR: el directori $PATHSETUP no és accessible" >> "$log_dir/log.log"
    exit 2
fi

# Creem el directori de l'empresa dins de la ruta especificada
empresa_dir="$PATHSETUP/$empresa"
mkdir -p "$empresa_dir" 2>/dev/null
if [ $? -ne 0 ]; then
    # Si ja existeix l'empresa o hi ha un problema, escrivim l'error al fitxer de registre
    echo "$(date) $(whoami) ERROR: Ja existeix o no es pot crear el directori de l'empresa $empresa a $PATHSETUP" >> "$log_dir/log.log"
    exit 3
fi

# Creem el directori del projecte dins del directori de l'empresa
projecte_dir="$empresa_dir/$projecte"
mkdir -p "$projecte_dir/codi" "$projecte_dir/documentacio/legal" "$projecte_dir/documentacio/manuals" 2>/dev/null
if [ $? -ne 0 ]; then
    # Si el directori del projecte ja existeix, escrivim l'error al fitxer de registre
    echo "$(date) $(whoami) ERROR: Ja existeix el projecte $projecte per l'empresa $empresa" >> "$log_dir/log.log"
    exit 3
fi

# Missatges d'informació
echo "Directoris $empresa_dir i $projecte_dir creats correctament"


# Fi del programa, sortim amb codi d'error 0
exit 0
