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

Generar claus SSH des del Fedora
```
ssh-keygen -t rsa -b 2048
cd ~/.ssh
ssh-add id_rsa
```

Modifiquem permisos de ".ssh" i "authorized_keys"
```powershell
Set-Content -Path $env:USERPROFILE\.ssh\authorized_keys -Value "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCUqzQlqdjJRDUEbnuTFw/Md2T0LpqJhXz7aWDDm5oDnAJYf+96pSUXEeY+S3nkIdXqfz44PwD3+p7Z9ROWdIdgtyGeVwM5ULZ6AgYaz6SK9tiI+TNM8FHoANMeql/eWxsxoDCUZP87wxU/yxuoeVgMHEnSqx18W55Lkm/0bteS2UcxvXIp2uB5vbkOtyl8j2eVP0xc0lzvapoIJPOb6YX6OQP9zYI9rRZsaJtrk1cVp8kMivGPmyzoFZUNze5bpgoK2kk97koKeNX+7fHC1shUmDmS2xgY9bO4l7nfaoxyhKbSIGGmIf44B0SIryf5uEOqWN2CpbOAEFxSV9/hVMoH jcastanyer@fedora"

Set-Content -Path C:/ProgramData/ssh/administrators_authorized_keys -Value "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCUqzQlqdjJRDUEbnuTFw/Md2T0LpqJhXz7aWDDm5oDnAJYf+96pSUXEeY+S3nkIdXqfz44PwD3+p7Z9ROWdIdgtyGeVwM5ULZ6AgYaz6SK9tiI+TNM8FHoANMeql/eWxsxoDCUZP87wxU/yxuoeVgMHEnSqx18W55Lkm/0bteS2UcxvXIp2uB5vbkOtyl8j2eVP0xc0lzvapoIJPOb6YX6OQP9zYI9rRZsaJtrk1cVp8kMivGPmyzoFZUNze5bpgoK2kk97koKeNX+7fHC1shUmDmS2xgY9bO4l7nfaoxyhKbSIGGmIf44B0SIryf5uEOqWN2CpbOAEFxSV9/hVMoH jcastanyer@fedora"

icacls $env:USERPROFILE\.ssh /inheritance:r
icacls $env:USERPROFILE\.ssh /grant "$($env:USERNAME):(OI)(CI)F"
icacls $env:USERPROFILE\.ssh\authorized_keys /grant "$($env:USERNAME):F"
```

Descomentar la seguent linia de "C:\ProgramData\ssh\sshd_config"
```
PubkeyAuthentication yes
```

Modificar la seguent linia de "C:\ProgramData\ssh\sshd_config"
```
PasswordAuthentication no
```

Reiniciar el server i canviem el nom
```powershell
# Reiniciar SSH
Restart-Service sshd

# Canviar hostname i reiniciar servidor
Rename-Computer -NewName "WS22" -Restart
```

```bash
# Connectar per SSH al server
ssh Joaquim@ec2-52-23-197-70.compute-1.amazonaws.com
```
