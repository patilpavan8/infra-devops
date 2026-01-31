# DevOps Project: GitLab CI/CD + DNS + Reverse Proxy + Docker + Terraform

## 🚀 Project Overview

This project demonstrates how to deploy a **Nginx reverse proxy** using:

* **GitLab CI/CD** for automated deployment
* **Docker** for containerized Nginx
* **Terraform** for provisioning a cloud VM and DNS records
* **Caching** for static assets
* **Rate limiting** to protect backend traffic

The backend can be **GitLab Pages, GitLab repository, or any HTTP service**.

---

## 🏗 Architecture

```
User
 │
 ▼
DNS (Terraform)
 │
 ▼
Cloud VM (Terraform)
 │
 ▼
Dockerized Nginx Reverse Proxy
 │
 ├── Static caching
 ├── Rate limiting
 └── GitLab Pages / HTTP backend
 │
 ▼
GitLab CI/CD Pipeline → Auto-deploy Nginx Docker
```

---

## 📁 Repository Structure

```
devops-reverse-proxy/
├── docker/
│   ├── Dockerfile
│   └── nginx.conf
├── nginx/
│   └── proxy.conf
├── terraform/
│   ├── main.tf
│   ├── variables.tf
│   └── outputs.tf
├── .gitlab-ci.yml
├── README.md
```

---

## Deployment Flow

1. Push code to `main` branch
2. GitLab CI/CD builds Docker image
3. Pipeline SSHs into VM
4. Stops old container and runs new Nginx container
5. Users access your reverse proxy via your domain

---

## Features Implemented

* DNS provisioning (Terraform)
* Reverse proxy to GitLab Pages or repo
* Static content caching with Nginx
* Rate limiting per IP
* Dockerized infrastructure
* GitLab CI/CD automated deployment

---
