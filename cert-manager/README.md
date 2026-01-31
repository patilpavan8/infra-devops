# cert-manager

**cert-manager** is a Helm chart to deploy a Web Certificate Manager that handles certificates for your Kubernetes workloads and integrates with the ExternalSecret stack for pushing secrets to external secret stores.

---

## Table of Contents

* [Overview](#overview)
* [Prerequisites](#prerequisites)
* [Installation](#installation)
* [Configuration](#configuration)
* [Certificate Management](#certificate-management)
* [Push Secrets](#push-secrets)
* [Example `values.yaml`](#example-valuesyaml)
* [Workflow](#workflow)
* [License](#license)

---

## Overview

The `cert-manager` Helm chart deploys:

1. **Cert-Manager Issuer** – Handles ACME-based certificate issuance (e.g., Let's Encrypt).
2. **Wildcard Certificate** – Automatically issues wildcard certificates for specified domains.
3. **PushSecrets** – Integrates with ExternalSecrets to push certificates to external secret stores like Azure Key Vault.

This chart automates TLS certificate management while keeping secrets synchronized with external stores.

---

## Prerequisites

* Kubernetes 1.21+
* Helm 3.0+
* [cert-manager](https://cert-manager.io/docs/) installed in the cluster
* [ExternalSecrets](https://external-secrets.io/) installed in the cluster

Optional: Azure account for DNS-01 challenges if using Azure DNS for ACME verification.

---

## Installation

Install the chart with the release name `my-cert-manager`:

```bash
helm install my-cert-manager ./cert-manager
```

Upgrade an existing release:

```bash
helm upgrade my-cert-manager ./cert-manager
```

---

## Configuration

The following table lists configurable parameters and default values:

| Parameter                                                            | Description                                                       | Default                                          |
| -------------------------------------------------------------------- | ----------------------------------------------------------------- | ------------------------------------------------ |
| `pushSecrets.wildcardTlsCert.enabled`                                | Enable pushing wildcard TLS certificate to external secret stores | `false`                                          |
| `pushSecrets.wildcardTlsCert.targetName`                             | Name of the Kubernetes secret to push                             | `cert-manager-main-secret`                   |
| `pushSecrets.wildcardTlsCert.secretKeys.tlsCrt`                      | Certificate key in the target secret                              | `wildcard-tls-crt`                               |
| `pushSecrets.wildcardTlsCert.secretKeys.tlsKey`                      | Private key in the target secret                                  | `wildcard-tls-key`                               |
| `wildcardCertificate.enabled`                                        | Enable creation of a wildcard certificate                         | `false`                                          |
| `wildcardCertificate.dnsName`                                        | Domain name for the wildcard certificate                          | `null`                                           |
| `wildcardCertificate.issuer.name`                                    | Name of the Cert-Manager issuer                                   | `letsencrypt-prod`                               |
| `wildcardCertificate.issuer.server`                                  | ACME server URL                                                   | `https://acme-v02.api.letsencrypt.org/directory` |
| `wildcardCertificate.issuer.dnsChallenge.azureDns.subscriptionID`    | Azure subscription ID for DNS challenge                           | `null`                                           |
| `wildcardCertificate.issuer.dnsChallenge.azureDns.resourceGroupName` | Azure resource group for DNS zone                                 | `null`                                           |
| `wildcardCertificate.issuer.dnsChallenge.azureDns.domain`            | Azure hosted domain                                               | `null`                                           |

Override values using a custom `values.yaml` file:

```bash
helm install my-cert-manager ./cert-manager -f my-values.yaml
```

---

## Certificate Management

If `wildcardCertificate.enabled` is `true`, the chart will create:

* **Issuer**: Cert-Manager issuer configured with ACME DNS-01 challenge (e.g., Azure DNS).
* **Certificate**: Wildcard certificate stored in a Kubernetes secret.

This allows automated issuance and renewal of TLS certificates.

---

## Push Secrets

If `pushSecrets.wildcardTlsCert.enabled` is `true`, the chart creates a **PushSecret** resource that synchronizes the wildcard certificate and private key with an external secret store (e.g., Azure Key Vault).

This is useful for applications outside Kubernetes that require access to TLS secrets.

---

## Example `values.yaml`

```yaml
# values.yaml for cert-manager
# Example configuration with wildcard certificate and push secret enabled

pushSecrets:
  wildcardTlsCert:
    enabled: true
    targetName: 'cert-manager-main-secret'
    secretKeys:
      tlsCrt: 'wildcard-tls-crt'
      tlsKey: 'wildcard-tls-key'

wildcardCertificate:
  enabled: true
  dnsName: 'example.com'
  issuer:
    name: "letsencrypt-prod"
    server: "https://acme-v02.api.letsencrypt.org/directory"
    dnsChallenge:
      azureDns:
        subscriptionID: 'xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx'
        resourceGroupName: 'my-dns-rg'
        domain: 'example.com'
```

This configuration will:

1. Create a **Cert-Manager Issuer** (`letsencrypt-prod`) using ACME DNS-01 challenge with Azure DNS.
2. Issue a **wildcard certificate** for `*.example.com`.
3. Push the certificate and key to an **ExternalSecrets PushSecret** for storage in an external secret store.

---

## Workflow

```
           ┌─────────────────────┐
           │  User / Application │
           └─────────┬───────────┘
                     │
                     ▼
           ┌─────────────────────┐
           │ Helm Chart Install  │
           │ cert-manager    │
           └─────────┬───────────┘
                     │
                     ▼
           ┌─────────────────────┐
           │ Cert-Manager Issuer │
           │ (ACME DNS-01)       │
           └─────────┬───────────┘
                     │
                     ▼
           ┌─────────────────────┐
           │ Wildcard Certificate│
           │ (*.example.com)     │
           │ Stored in K8s Secret│
           └─────────┬───────────┘
                     │
                     ▼
           ┌─────────────────────┐
           │ PushSecret (External│
           │ Secret Store e.g., │
           │ Azure Key Vault)   │
           └─────────┬───────────┘
                     │
                     ▼
           ┌─────────────────────┐
           │ Applications /      │
           │ Services consume    │
           │ TLS secrets         │
           └─────────────────────┘
```

**Legend / Icons**:

* `┌─┐` / `└─┘` → Resource container
* `▼` → Flow / action
* `K8s Secret` → Kubernetes secret
* `PushSecret` → ExternalSecrets resource
