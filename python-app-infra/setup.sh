#!/usr/bin/env bash
set -euo pipefail

REQUIRED_TOOLS=(docker kubectl helm terraform minikube)

missing=()
for tool in "${REQUIRED_TOOLS[@]}"; do
  if ! command -v "$tool" >/dev/null 2>&1; then
    missing+=("$tool")
  fi
done

if [[ ${#missing[@]} -gt 0 ]]; then
  echo "Missing required tools: ${missing[*]}"
  echo "Install them and re-run ./setup.sh"
  exit 1
fi

if ! minikube status >/dev/null 2>&1; then
  echo "Starting Minikube..."
  minikube start
else
  echo "Minikube is already running."
fi

echo "Setting kubectl context to minikube..."
kubectl config use-context minikube >/dev/null

echo "Enabling metrics-server addon..."
minikube addons enable metrics-server >/dev/null

echo "Enabling ingress addon..."
minikube addons enable ingress >/dev/null

echo "Setup complete."
echo "Next: review assignment/DEVOPS_HIRING_TASK.md"
