# Funcionament de l'script per comprovar la mida d'un fitxer

Aquest document explica el funcionament de l'script creat en Bash per comprovar si la mida d'un fitxer és més gran que una mida especificada per l'usuari. Si la mida del fitxer supera la mida límit, es genera una alerta, que es registra en un fitxer de log i es mostra per pantalla.

## Contingut

1. [Introducció](#introducció)
2. [Com s'utilitza l'script](#com-sutilitza-lscript)
3. [Com funciona l'script](#com-funciona-lscript)
4. [Exemples d'ús](#exemples-dus)
5. [Notes importants](#notes-importants)

## Introducció

L'script de comprovació de mida de fitxers és una eina per assegurar-se que els fitxers no superin una mida determinat per l'usuari. Si el fitxer és més gran que la mida especificada, l'script registra aquesta situació i alerta a l'usuari tant per pantalla com en un fitxer de log.

## Com s'utilitza l'script

Per executar l'script, utilitza la següent sintaxi:

```bash
./comprova_mida.sh <mida (KB)> <fitxer>
```

- `<mida (KB)>`: La mida màxima del fitxer en KB. 
- `<fitxer>`: El nom del fitxer que es vol comprovar.

## Exemples d'ús

### 1. **Error per nombre incorrecte d'arguments**

Si no passes els dos arguments, l'script mostrarà un missatge d'ús correcte i sortirà amb codi d'error.

```bash
./comprova_mida.sh
```

**Sortida esperada:**
