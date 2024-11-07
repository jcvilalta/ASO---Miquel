# Primer executo la següent comanda per descarregar Powershell 7
```
Invoke-WebRequest -Uri https://github.com/PowerShell/PowerShell/releases/download/v7.4.0/PowerShell-7.4.0-win-x64.msi -OutFile C:\PowerShell-7.4.0-win-x64.msi```

# Un cop me l'he baixat, per instal·lar-lo executo el següent
```
msiexec /i C:\PowerShell-7.4.0-win-x64.msi /quiet /norestart
```
