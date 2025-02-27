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

## Fitxer YAML pel deployment d'Odoo
```bash
nano odoo-deployment.yaml
```

Posem el següent contingut
```bash
apiVersion: apps/v1
kind: Deployment
metadata:
  name: odoo
  namespace: odoo
spec:
  replicas: 1
  selector:
    matchLabels:
      app: odoo
  template:
    metadata:
      labels:
        app: odoo
    spec:
      containers:
      - name: odoo
        image: odoo:latest
        env:
        - name: POSTGRES_PORT
          value: "5432"
        - name: POSTGRES_DB
          value: odoo
        - name: POSTGRES_USER
          value: asix
        - name: POSTGRES_PASSWORD
          value: ZusBNvER
        ports:
        - containerPort: 8069

```

## Fitxer YAML pel servei d'Odoo
```bash
nano odoo-service.yaml
```

Posem el següent contingut
```bash
apiVersion: v1
kind: Service
metadata:
  name: odoo-service
  namespace: odoo
spec:
  selector:
    app: odoo
  ports:
    - protocol: TCP
      port: 80
      targetPort: 8069
  type: LoadBalancer

```

## Aplicar la configuració a Kubernetes
```bash
kubectl apply -f postgres-deployment.yaml
kubectl apply -f postgres-service.yaml
kubectl apply -f odoo-deployment.yaml
kubectl apply -f odoo-service.yaml
```

Hauriem de veure el següent "output"
```bash
deployment.apps/odoo-db created
service/odoo-db-service created
deployment.apps/odoo created
service/odoo-service created
```

## Comprovem que s'ha desplegat correctament
```bash
kubectl get deployments -n odoo
```

```bash
kubectl get svc -n odoo
```

```bash
kubectl get pods -n odoo
```
