# Ara realitzaré la instal·lació d'SSH
## Per fer això ho faré mitjançant comandes, la primera comanda que hem d'executar és la següent
```
Add-WindowsCapability -Online -Name OpenSSH.Server~~~~0.0.1.0
```

## Ara ja tenim el servei insal·lat, anem a configurar-lo perquè s'iniciï automàticament, ho fem amb les següents comandes
```
Start-Service sshd
Set-Service -Name sshd -StartupType 'Automatic'
```

## Ara vull verificar l'estat del servei, per tant executo la següent comanda i observo la sortida
```
Get-Service -Name sshd
```
![image](https://github.com/user-attachments/assets/dba22bc7-aef8-45a5-be0b-2fa4aab79562)

## Ara vaig a permetre el trànsit SSH al tallafoc amb la següent comanda
```
New-NetFirewallRule -Name sshd -DisplayName 'Allow SSH' -Protocol TCP -LocalPort 22 -Action Allow
```
![image](https://github.com/user-attachments/assets/8a0aa288-1859-4b52-be96-6ff357e76461)

## Amb aquests passos ja tindriem el servei SSH instal·lat a la màquina
