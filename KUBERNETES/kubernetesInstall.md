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
1.3. Desactivar Swap (si hi ha partició swap)
```bash
sudo swapoff -a
sudo sed -i '/ swap / s/^/#/' /etc/fstab
```

1.4. Carregar mòduls del kernel necessaris
```bash
cat <<EOF | sudo tee /etc/modules-load.d/k8s.conf
overlay
br_netfilter
EOF

sudo modprobe overlay
sudo modprobe br_netfilter
```
