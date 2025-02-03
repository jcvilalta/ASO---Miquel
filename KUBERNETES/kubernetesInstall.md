# Instal·larem Kubernetes
1. Configuració prèvia als 3 nodes
1.1. Actualitzar el sistema
```bash
sudo apt update && sudo apt upgrade -y
```
1.2. Configurar noms d'host
Executa en cada servidor el següent, canviant el nom segons correspongui:
Master:
```bash
sudo hostnamectl set-hostname master01b
```
Worker 1:
```bash
sudo hostnamectl set-hostname worker01b
```
Worker 2:
```bash
sudo hostnamectl set-hostname worker02b
```

Afegir els noms d'host al fitxer /etc/hosts a tots els servidors:
```bash
echo "192.168.0.120 master01b" | sudo tee -a /etc/hosts
echo "192.168.0.121 worker01b" | sudo tee -a /etc/hosts
echo "192.168.0.122 worker02b" | sudo tee -a /etc/hosts
```
