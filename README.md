# TLAOKAS Helm Chart

> Helm chart for deploying both the backend and frontend of [The Lost Art of Keeping a Secret](https://github.com/SimonBorin/tlaokas) in Kubernetes.

---

## 📌 Overview

This chart deploys:

- **Backend** — [Go service](https://github.com/SimonBorin/tlaokas) that securely stores encrypted secrets in PostgreSQL.
- **Frontend** — [React app](https://github.com/SimonBorin/tlaokas-front) that allows users to create and view one-time secrets.
- A shared **Ingress**, optionally configured with HTTPS (ALB + ACM certificate support).

Secrets are deleted after the first view or 12 hours — whichever comes first.

---

## 🚀 Installation

First, add this chart repo to Helm:

```bash
helm repo add tlaokas https://simonborin.github.io/tlaokas-chart
helm repo update
```

Then install it:

```bash
helm install tlaokas tlaokas/tlaokas \
  --namespace secrets \
  --create-namespace \
  -f my-values.yaml
```

---

## 🧾 Example `values.yaml`

```yaml
image:
  backend:
    repository: mrblooomberg/thelostartofkeepingasecret
    tag: v1.0.0
  frontend:
    repository: mrblooomberg/thelostartofkeepingasecret-front
    tag: v1.0.0

ingress:
  enabled: true
  host: secretshare.example.com
  certificateArn: arn:aws:acm:us-west-2:123456789012:certificate/abcde-12345

backend:
  secret:
    name: tlaokas-db-secret
    key:
      user: DB_USER
      pass: DB_PASSWORD

database:
  host: tlaokas-db.rds.amazonaws.com
  port: 5432
  name: secretdb
  table: secrets
```

---

## 🔐 Secrets

This chart expects a pre-created Kubernetes `Secret` with the database credentials:

```yaml
apiVersion: v1
kind: Secret
metadata:
  name: tlaokas-db-secret
type: Opaque
stringData:
  DB_USER: youruser
  DB_PASSWORD: yourpassword
```

Or use [External Secrets Operator](https://external-secrets.io/) to sync from a cloud secret manager.

---

## 📃 License

This project is licensed under the [MIT License](https://opensource.org/licenses/MIT).

---

## 🙌 Acknowledgements

Pet project by [SimonBorin](https://github.com/SimonBorin) for learning Go, React, Kubernetes, and secure app architecture.
Inspired by tools like [onetimesecret](https://onetimesecret.com/).
