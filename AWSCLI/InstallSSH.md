# Instal·lació SSH (Powershell)
```powershell
# Instal·lar el servei SSH
Add-WindowsCapability -Online -Name OpenSSH.Server~~~~0.0.1.0

# Iniciar el servei SSH
Start-Service sshd

# Activar l'inici automàtic del servei
Set-Service -Name sshd -StartupType 'Automatic'

# Permetre les connexions SSH al firewall
New-NetFirewallRule -Name sshd -DisplayName 'OpenSSH Server (sshd)' -Enabled True -Direction Inbound -Protocol TCP -Action Allow -LocalPort 22

# Afegir l'usuari administrador al grup Remote Management
Add-LocalGroupMember -Group "Remote Management Users" -Member "Administrator"

# Creació de la carpeta on guardem les claus SSH
New-Item -ItemType Directory -Path $env:USERPROFILE\.ssh -Force
```

Generar claus SSH
```
ssh-keygen -t rsa -b 2048
cd ~/.ssh
ssh-add id_rsa
```
