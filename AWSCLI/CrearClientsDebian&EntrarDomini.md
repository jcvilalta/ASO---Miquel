# Crearem els clients Debian i els entrarem al domini

Creem els clients
```bash
aws ec2 run-instances \
--image-id "ami-064519b8c76274859" \
--instance-type "t2.micro" \
--key-name "AWS" \
--block-device-mappings '{"DeviceName":"/dev/xvda","Ebs":{"Encrypted":false,"DeleteOnTermination":true,"Iops":3000,"SnapshotId":"snap-0e3a4e2ca23a73496","VolumeSize":50,"VolumeType":"gp3","Throughput":125}}' \
--network-interfaces '{"SubnetId":"subnet-07a60e4be91dcc4eb", "AssociatePublicIpAddress":true,"DeviceIndex":0,"Groups":["sg-0a42f2a3cda179b53"]}' \
--credit-specification '{"CpuCredits":"standard"}' --tag-specifications '{"ResourceType":"instance","Tags":[{"Key":"Name","Value":"Debian12"}]}' \
--private-dns-name-options '{"HostnameType":"ip-name","EnableResourceNameDnsARecord":true,"EnableResourceNameDnsAAAARecord":false}' \
--count "1"
```

Per entrar el client al domini executarem les següents comandes
```bash
# Actualitzem i instal·lem el sistema
sudo apt update
sudo apt install realmd sssd samba-common-bin adcli -y

# Afegim la ruta del Windows Server
echo "nameserver <IPServer>" | sudo tee /etc/resolv.conf

# L'entrem al domini
echo "Patata123*" | sudo realm join --user="Administrator" "xukim.local" --install=/ -v
```
