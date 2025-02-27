# Script de monitoratge de recursos

1. [Què monitoritzarem?](#1-què-monitoritzarem)
2. [Com obtenim aquesta informació?](#2-com-obtenim-aquesta-informació)
3. [Com s'executarà?](#3-com-sexecutarà)
4. [Com enviem notificacions?](#4-com-enviem-notificacions)
    - [Notify-send (notificacions gràfiques)](#notify-send-notificacions-gràfiques)
    - [Enviament de correus](#enviament-de-correus)
    - [Registre en un fitxer de logs](#registre-en-un-fitxer-de-logs)
    - [Enviar una alerta a un canal de Telegram o Discord](#enviar-una-alerta-a-un-canal-de-telegram-o-discord)
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

## 4. Com enviem notificacions?

Hi ha diverses opcions:

### Notify-send (notificacions gràfiques)

És una eina que permet enviar notificacions a l'escriptori de Linux.

**Exemple**:

```bash
notify-send "Alerta CPU" "L'ús de la CPU ha superat el 90%!"
```
No podré fer servir aquesta opció, ja que requereix un entorn gràfic, així que si s'executa en un servidor sense GUI no funcionarà.

### Enviament de correus

Podem fer servir `mail` o `sendmail` per enviar un correu si un recurs supera el límit.
**Exemple:**
```bash
echo "L'ús de la CPU és massa alt" | mail -s "Alerta CPU" usuari@correu.com
```
Requerim d'un servidor de correu (com `Postfix` o `ssmtp`).
_No ho considero una opció gaire útil_

### Registre en un fitxer de logs
Podem guardar les alertes en un fitxer com `/var/log/monitor.log`.
**Exemple**
```bash
echo "$(date) - ALERTA: CPU al 90%" >> /var/log/monitor.log```
```

### Enviar una alerta a un canal de Telegram o Discord
Es podria integrar amb un bot de Telegram o un webhook de Discord.
