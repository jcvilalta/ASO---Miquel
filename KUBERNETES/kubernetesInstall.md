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

1.5. Configurar paràmetres del sistema
```bash
cat <<EOF | sudo tee /etc/sysctl.d/k8s.conf
net.bridge.bridge-nf-call-iptables = 1
net.bridge.bridge-nf-call-ip6tables = 1
net.ipv4.ip_forward = 1
EOF

sudo sysctl --system
# Hauriem d'obtenir una sortida com la següent:
worker01b@worker01B:~$ sudo sysctl --system
* Applying /usr/lib/sysctl.d/50-pid-max.conf ...
* Applying /usr/lib/sysctl.d/99-protect-links.conf ...
* Applying /etc/sysctl.d/99-sysctl.conf ...
* Applying /etc/sysctl.d/k8s.conf ...
* Applying /etc/sysctl.conf ...
kernel.pid_max = 4194304
fs.protected_fifos = 1
fs.protected_hardlinks = 1
fs.protected_regular = 2
fs.protected_symlinks = 1
net.bridge.bridge-nf-call-iptables = 1
net.bridge.bridge-nf-call-ip6tables = 1
net.ipv4.ip_forward = 1
```
