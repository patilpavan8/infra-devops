#!/usr/bin/env bash
set -e

echo "Building Docker image..."
docker build -t lamp-catalog:latest ./starter-code/lamp-catalog-service

echo "Loading image into Minikube..."
minikube image load lamp-catalog:latest

echo "Deploying via Helm..."
helm upgrade --install lamp ./helm/lamp-catalog

echo "Waiting for pods..."
kubectl rollout status deployment/lamp-lamp

echo "Service URL:"
minikube service lamp-service -n lamp-catalog --url
