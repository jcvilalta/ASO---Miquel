# Script de monitoratge de recursos
## 1. Què monitoritzarem?

- **CPU**: Percentatge d’ús (per exemple, alerta si supera el 90%).
- **Memòria RAM**: Percentatge d’ús (per exemple, alerta si supera el 80%).
- **Espai en disc**: Percentatge d’ús d’una partició específica (per exemple, `/` si supera el 85%).
- _**Opcional**: També podríem afegir monitorització de xarxa (ús d’amplada de banda)._

## 2. Com obtenim aquesta informació?

Farem servir comandes de Linux:

- **CPU**: `top` o `mpstat`
- **Memòria**: `free -m`
- **Disc**: `df -h`
- _**Xarxa (opcional)**: `vnstat` o `ifstat`_

## 3. Com s'executarà?

Podem fer que el script s'executi en bucle cada X segons (per exemple, cada 5 segons) amb:

```bash
while true; do ... done
```
També es podria executar com a cron job cada minut si no volem que estigui en execució contínua.
