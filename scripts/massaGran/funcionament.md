# Funcionament de l'script per comprovar la mida d'un fitxer

Aquest document explica el funcionament de l'script creat en Bash per comprovar si la mida d'un fitxer és més gran que una mida especificada per l'usuari. Si la mida del fitxer supera la mida límit, es genera una alerta, que es registra en un fitxer de log i es mostra per pantalla.

## Contingut

[Introducció](#introducció)
[Com s'utilitza l'script](#com-sutilitza-lscript)
[Exemples d'ús](#exemples-dus)
[Notes importants](#notes-importants)

## Introducció

L'script de comprovació de mida de fitxers és una eina per assegurar-se que els fitxers no superin una mida determinat per l'usuari. Si el fitxer és més gran que la mida especificada, l'script registra aquesta situació i alerta a l'usuari tant per pantalla com en un fitxer de log.

## Com s'utilitza l'script

Per executar l'script, utilitza la següent sintaxi:

```bash
./massaGran.sh <mida (KB)> <fitxer>
```

- `<mida (KB)>`: La mida màxima del fitxer en KB. 
- `<fitxer>`: El nom del fitxer que es vol comprovar.

## Exemples d'ús

### 1. **Error per nombre incorrecte d'arguments**

Si no passes els dos arguments, l'script mostrarà un missatge d'ús correcte i sortirà amb codi d'error.

```bash
./massaGran.sh
```

**Sortida esperada:**
```bash
Ús correcte: ./massaGran.sh <mida (KB)> <fitxer>
```

### 2. **Error si el fitxer no existeix**

Si el fitxer no existeix, l'script registrarà un error al fitxer de logs:

```bash
./massaGran.sh 1000 fitxer_no_existent.txt
```

**Log:**
```bash
2025-02-16 10:30:45 - Usuari: root - ERROR: fitxer_no_existent.txt no existeix.
```

### 3. **El fitxer és més petit que la mida especificada**

Si el fitxer és més petit que la mida especificada, no es farà cap registre.

```bash
touch fitxerPetit.txt  # Crear un fitxer de prova de 0 kB
./massaGran.sh 200 fitxerPetit.txt
```

**No hi haurà registre al log.**

### 4. **El fitxer és més gran que la mida especificada**

Si el fitxer és més gran que la mida especificada, l'script registrarà l'alerta al log i també la mostrarà per pantalla.

```bash
dd if=/dev/zero of=fitxerGran.txt bs=1K count=1500  # Crear un fitxer de 1500 kB
./massaGran.sh 1000 fitxerGran.txt
```

**Log:**
```bash
2025-02-16 10:35:45 - ALERTA: El fitxer fitxerGran.txt és més gran que 1000 kB (Diferència: 500 kB). Usuari: root
```
**Pantalla:**
```bash
ALERTA: El fitxer fitxerGran.txt és més gran que 1000 kB (Diferència: 500 kB).
```


## Notes importants

- L'script utilitza la comanda `du -k` per obtenir la mida del fitxer en kB. La comanda `cut -f1` s'utilitza per extreure només la mida en bytes.
- El fitxer de logs es troba a `/var/log/scriptsErrors/massaGran/massaGran.log`. Assegura't que l'usuari que executa l'script tingui permisos d'escriptura a aquest fitxer.
