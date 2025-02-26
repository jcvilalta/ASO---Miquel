# Instal·larem Odoo
## Crear un espai
```bash
kubectl create namespace odoo
```
## Crear YAML per PostgreSQL i Odoo

```bash
mkdir ~/odoo
cd ~/odoo
nano postgres-deployment.yaml
```
Posem el següent contingut
```bash
apiVersion: apps/v1
kind: Deployment
metadata:
  name: odoo-db
  namespace: odoo
spec:
  replicas: 1
  selector:
    matchLabels:
      app: odoo-db
  template:
    metadata:
      labels:
        app: odoo-db
    spec:
      containers:
      - name: postgres
        image: postgres:13
        env:
        - name: POSTGRES_USER
          value: asix
        - name: POSTGRES_PASSWORD
          value: ZusBNvER
        - name: POSTGRES_DB
          value: odoo
        ports:
        - containerPort: 5432
```
