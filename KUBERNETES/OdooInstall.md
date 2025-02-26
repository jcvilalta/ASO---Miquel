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

## Fitxer pel servei PostgreSQL
```bash
nano postgres-service.yaml
```

Posem el següent contingut
```bash
apiVersion: v1
kind: Service
metadata:
  name: odoo-db-service
  namespace: odoo
spec:
  selector:
    app: odoo-db
  ports:
    - protocol: TCP
      port: 5432
      targetPort: 5432
  clusterIP: None
```
