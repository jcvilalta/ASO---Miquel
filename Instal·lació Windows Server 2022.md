
# Instal·lació Windows Server

aws ec2 run-instances --image-id "ami-05f283f34603d6aed" --instance-type "t2.micro" --key-name "vockey" --network-interfaces '{"AssociatePublicIpAddress":true,"DeviceIndex":0,"Groups":["sg-04af52ffb66284585"]}' --credit-specification '{"CpuCredits":"standard"}' --tag-specifications '{"ResourceType":"instance","Tags":[{"Key":"Name","Value":"Windows Server 2022"}]}' --metadata-options '{"HttpEndpoint":"enabled","HttpPutResponseHopLimit":2,"HttpTokens":"required"}' --private-dns-name-options '{"HostnameType":"ip-name","EnableResourceNameDnsARecord":true,"EnableResourceNameDnsAAAARecord":false}' --count "1" 


# Permetre accés per RDP
## Per poder-nos connectar per RDP hem de permetre l'accés a través de les regles d'entrada i sortida:
![image](https://github.com/user-attachments/assets/7e65feed-4739-4fca-a134-81a430a7ef01)
![image](https://github.com/user-attachments/assets/c5556029-c9bf-4b9d-8431-5af0f578cea8)

