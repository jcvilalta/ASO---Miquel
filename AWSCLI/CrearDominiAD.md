# Hem de crear i configurar el domini/forest d'Active Directory, ho farem de la següent manera
```powershell
# Instal·lar Active Directory
Install-WindowsFeature AD-Domain-Services -IncludeManagementTools
Import-Module ADDSDeployment

# Elevar el servidor a controlador de domini
Install-ADDSForest -DomainName "xukim.local" -DomainNetbiosName "WindowsServer22" -SafeModeAdministratorPassword (ConvertTo-SecureString -AsPlainText "Patata123*" -Force) -InstallDns -Force
```
