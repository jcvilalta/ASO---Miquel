
# Instal·lació Windows Server

aws ec2 run-instances --image-id "ami-05f283f34603d6aed" --instance-type "t2.micro" --key-name "vockey" --network-interfaces '{"AssociatePublicIpAddress":true,"DeviceIndex":0,"Groups":["sg-04af52ffb66284585"]}' --credit-specification '{"CpuCredits":"standard"}' --tag-specifications '{"ResourceType":"instance","Tags":[{"Key":"Name","Value":"Windows Server 2022"}]}' --metadata-options '{"HttpEndpoint":"enabled","HttpPutResponseHopLimit":2,"HttpTokens":"required"}' --private-dns-name-options '{"HostnameType":"ip-name","EnableResourceNameDnsARecord":true,"EnableResourceNameDnsAAAARecord":false}' --count "1" 


# Permetre accés per RDP
## Per poder-nos connectar per RDP hem de permetre l'accés a través de les regles d'entrada i sortida:
![image](https://github.com/user-attachments/assets/7e65feed-4739-4fca-a134-81a430a7ef01)
![image](https://github.com/user-attachments/assets/c5556029-c9bf-4b9d-8431-5af0f578cea8)

# Connectar per RDP
## Un cop hem permés l'accés per RDP ja ens podem connectar, per connectar-nos ho podem fer amb clic dret sobre la instància i després a "Connect":
![image](https://github.com/user-attachments/assets/dac9d330-9a0b-4e72-884a-a7e1e9f357fd)

## Se'ns obrirà aquesta pestanya, hem de fer clic a "RDP client"
![image](https://github.com/user-attachments/assets/cdc59148-dc0d-45e1-a5b8-631c686189cd)

## Quan estiguem a dins fem clic a "Download remote desktop file", ens baixarà l'arxiu .rdp amb el qual ens haurem de connectar, després fem clic a "Get password".
![image](https://github.com/user-attachments/assets/0b66bdf4-896f-42e0-a161-92c376d89f10)

## Quan haguem fet clic a "Get password" ens obrirà la següent pestanya on hem de pujar el fitxer .pem
![image](https://github.com/user-attachments/assets/507729f9-65af-48c6-bf49-932d72488107)
