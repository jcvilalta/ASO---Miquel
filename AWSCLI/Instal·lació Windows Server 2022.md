
# Instal·lació Windows Server

aws ec2 run-instances --image-id "ami-05f283f34603d6aed" --instance-type "t2.micro" --key-name "vockey" --network-interfaces '{"AssociatePublicIpAddress":true,"DeviceIndex":0,"Groups":["sg-04af52ffb66284585"]}' --credit-specification '{"CpuCredits":"standard"}' --tag-specifications '{"ResourceType":"instance","Tags":[{"Key":"Name","Value":"Windows Server 2022"}]}' --metadata-options '{"HttpEndpoint":"enabled","HttpPutResponseHopLimit":2,"HttpTokens":"required"}' --private-dns-name-options '{"HostnameType":"ip-name","EnableResourceNameDnsARecord":true,"EnableResourceNameDnsAAAARecord":false}' --count "1" 


# Permetre accés per RDP
### Per poder-nos connectar per RDP hem de permetre l'accés a través de les regles d'entrada i sortida:
![image](https://github.com/user-attachments/assets/7e65feed-4739-4fca-a134-81a430a7ef01)
![image](https://github.com/user-attachments/assets/c5556029-c9bf-4b9d-8431-5af0f578cea8)

# Connectar per RDP
### Un cop hem permés l'accés per RDP ja ens podem connectar, per connectar-nos ho podem fer amb clic dret sobre la instància i després a "Connect":
![image](https://github.com/user-attachments/assets/dac9d330-9a0b-4e72-884a-a7e1e9f357fd)

### Se'ns obrirà aquesta pestanya, hem de fer clic a "RDP client"
![image](https://github.com/user-attachments/assets/cdc59148-dc0d-45e1-a5b8-631c686189cd)

### Quan estiguem a dins fem clic a "Download remote desktop file", ens baixarà l'arxiu .rdp amb el qual ens haurem de connectar, després fem clic a "Get password".
![image](https://github.com/user-attachments/assets/0b66bdf4-896f-42e0-a161-92c376d89f10)

### Quan haguem fet clic a "Get password" ens obrirà la següent pestanya on hem de pujar el fitxer .pem
![image](https://github.com/user-attachments/assets/507729f9-65af-48c6-bf49-932d72488107)

### El .pem ens el baixem abans d'entrar al laboratori, fem clic a "AWS Details" i després a "Download PEM" 
![image](https://github.com/user-attachments/assets/721cd859-d4c8-4538-9b88-e58b82915ae5)

### Ara ja podem pujar el fitxer, fem clic a "Upload private key file", busquem el fitxer i ja podem desxifrar la contrasenya
![image](https://github.com/user-attachments/assets/cb4ddc2b-d55f-4594-826a-60a1f5f2946e)

### Comq que ja tenim el fitxer .rdp baixat només hem de copiar la contrasenya i ja el podem obrir
![image](https://github.com/user-attachments/assets/0b286e8e-e588-4b05-8be4-558aa699fcc9)

### Quan ja hem fet tots aquests passos ja podem obrir el fitxer .rdp i fem clic a "Connect"
![image](https://github.com/user-attachments/assets/eed38ab0-c1fd-4009-af1c-d24db709bdd0)

### Ens demanarà la contrasenya, és la que hem desxifrat abans, la copiem i la posem, ja podem connectar-nos
![image](https://github.com/user-attachments/assets/5392b0ca-3d6a-4ec4-8670-6953c98546e7)

### Li diem que si que ens volem connectar
![image](https://github.com/user-attachments/assets/97701e2c-d63f-4450-bbe2-5a78bd7f87ae)

### Ja estem connectats
![image](https://github.com/user-attachments/assets/cf392984-c8c8-4a6c-910f-b8f66d52f2b1)


# Instal·lació Windows Server 2022 i creació del domini via script
Per crear el servidor ho farem amb la següent configuració:
```bash
aws ec2 run-instances \
--image-id "ami-05f283f34603d6aed" \
--instance-type "t2.micro" \
--key-name "AWS" \
--network-interfaces '{"SubnetId":"subnet-07a60e4be91dcc4eb", "AssociatePublicIpAddress":true,"DeviceIndex":0,"Groups":["sg-0a42f2a3cda179b53"]}' \
--credit-specification '{"CpuCredits":"standard"}' \
--tag-specifications '{"ResourceType":"instance","Tags":[{"Key":"Name","Value":"WS22"}]}' \
--private-dns-name-options '{"HostnameType":"ip-name","EnableResourceNameDnsARecord":true,"EnableResourceNameDnsAAAARecord":false}' \
--count "1" 
```

Quan s'hagi crear el servidor entrem per RDP i [instal·lem SSH](https://github.com/jcvilalta/jcvilalta/blob/main/AWSCLI/Instal%C2%B7laci%C3%B3%20SSH.md)

[Instal·lar SSH via script](AWSCLI/Instal·lacióSSH.md)
