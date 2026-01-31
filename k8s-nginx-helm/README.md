# Kubernetes Nginx Helm Chart ☸️

This repository provides a **Kubernetes example** demonstrating how to deploy **Nginx using Helm**, including **Ingress**, **resource limits**, and **Horizontal Pod Autoscaling (HPA)**.

The project is intentionally structured to reflect real-world, cloud-native best practices and is suitable for portfolios, demos, and learning purposes.

---

## 🚀 Features

- Helm-based application deployment
- Kubernetes Deployment and Service
- Ingress support (NGINX Ingress Controller compatible)
- CPU and memory resource requests and limits
- Horizontal Pod Autoscaler (HPA)
- Clean, extensible Helm chart layout

---

## 📁 Project Structure

```
k8s-nginx-helm/
├── README.md
└── helm/
    └── nginx/
        ├── Chart.yaml
        ├── values.yaml
        └── templates/
            ├── deployment.yaml
            ├── service.yaml
            ├── ingress.yaml
            └── hpa.yaml
```

---

## 📦 Prerequisites

- Kubernetes cluster (Minikube, Kind, EKS, GKE, or AKS)
- kubectl configured with cluster access
- Helm v3 or newer
- Metrics Server installed (required for HPA)

---

## ▶️ Installation

Install the Helm chart:

```bash
helm install nginx ./helm/nginx
```

Upgrade the release after changes:

```bash
helm upgrade nginx ./helm/nginx
```

Uninstall the release:

```bash
helm uninstall nginx
```

---

## 🌐 Ingress (Local Testing with Minikube)

Enable the ingress addon:

```bash
minikube addons enable ingress
```

Add a local DNS entry:

```bash
echo "$(minikube ip) nginx.local" | sudo tee -a /etc/hosts
```

Open the application in a browser:

```
http://nginx.local
```

---

## 📊 Horizontal Pod Autoscaling

Autoscaling is configured using CPU utilization metrics.

Default configuration (defined in `values.yaml`):

- **Minimum replicas:** 2
- **Maximum replicas:** 5
- **Target CPU utilization:** 70%

The HorizontalPodAutoscaler automatically scales the application based on load.

---

## 🧠 Kubernetes Concepts Demonstrated

- Declarative infrastructure using YAML
- Helm templating and values-based configuration
- Resource management (CPU and memory)
- Ingress-based HTTP traffic routing
- Horizontal scaling with HPA
- Core cloud-native deployment patterns

---
