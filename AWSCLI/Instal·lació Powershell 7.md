# Primer executo la següent comanda per descarregar Powershell 7
## El que fa aquesta comanda és baixar un fitxer MSI
```
Invoke-WebRequest -Uri https://github.com/PowerShell/PowerShell/releases/download/v7.4.0/PowerShell-7.4.0-win-x64.msi -OutFile C:\PowerShell-7.4.0-win-x64.msi```
```


# Un cop me l'he baixat, per instal·lar-lo executo el següent
## Aquesta comanda executa el fitxer MSI que ens hem baixat amb la comanda anterior
```
msiexec /i C:\PowerShell-7.4.0-win-x64.msi /quiet /norestart
```
# Ara verificarem la instal·lació
## Executo Powershell 7 amb la següent comanda
```
'C:\Program Files\PowerShell\7\pwsh.exe'
```
## I ara executo la següent comanda per saber si ja estic treballant amb Powershell 7
```
$PSVersionTable.PSVersion
```
## L'output que m'ha donat confirma que estem amb Powershell 7
```
Major  Minor  Patch  PreReleaseLabel BuildLabel
-----  -----  -----  --------------- ----------
7      4      0
```
