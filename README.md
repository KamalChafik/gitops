# Flux GitOps Project

## Table of Contents

- [Overview](#overview)
  - [Machines & Hardware](#machines--hardware)
  - [Services](#services)
  - [Design](#design)
- [Project Structure](#project-structure)
  - [Ansible](#ansible)
  - [Applications (`app/`)](#applications-app)
  - [Cluster Configuration (`cluster/`)](#cluster-configuration-cluster)
  - [Portainer Stack (`portainer/`)](#portainer-stack-portainer)
- [Notes and Disclaimers](#notes-and-disclaimers)
- [Contributing & Advice](#contributing--advice)
- [License](#license)

---

## Overview

This project is a **GitOps-driven Kubernetes setup** using **FluxCD** to manage infrastructure and applications. It integrates automated deployments, monitoring, logging, and follows Infrastructure as Code (IaC) best practices to ensure **reliability, scalability, and maintainability**.

### Machines & Hardware

This project runs on **Linode Kubernetes Engine (LKE)** with a **3-node Kubernetes cluster** and a separate **Ubuntu VM** for infrastructure management.

- **Kubernetes Cluster (3 Nodes on Linode LKE)**
  - Runs all deployed applications using **FluxCD, Helm, and ITOps**.

- **Ubuntu VM**
  - Used for **monitoring, provisioning infrastructure, and cluster configuration**.
  - Hosts **Portainer** in **GitOps mode** for service deployment, along with the full monitoring stack.

### Services

#### Kubernetes Cluster (LKE - 3 Nodes)

- **FluxCD** – GitOps-based Kubernetes deployment automation.
- **Helm** – Package management for Kubernetes applications.
- **ITOps** – Infrastructure management through automation.
- **Traefik** – Ingress controller for managing external traffic.
- **Podinfo** – Example application for testing deployments.
- **Discord Notifications** – Real-time updates for GitOps events (In Progress).
- **Promtail** – Deployed in the cluster, collects logs from **Flux**, **Podinfo**, and **Traefik**, and forwards them to Loki.

#### Ubuntu VM (Monitoring & IaC)

- **OpenTofu** – Open-source alternative to Terraform.
- **Ansible** – Configuration management and automation (syncs config files from Git).
- **Portainer** – Service deployment in **GitOps mode** using a linked repository.
- **Semaphore** – UI for managing Ansible playbooks and OpenTofu pipelines.
- **Grafana** – Metrics and logs dashboard.
- **Prometheus** – Metrics collection and alerting.
- **Loki** – Log aggregation backend that receives logs from the Kubernetes cluster.
- **Uptime Kuma** – Availability monitoring for services with 60s alert threshold.

---

## Project Structure

### Ansible (`ansible/playbooks/`)

Contains playbooks to manage and automate tasks related to infrastructure updates, reboots, and syncing config files from Git.

| File                        | Description                                                                 |
| --------------------------- | --------------------------------------------------------------------------- |
| `check-reboot.yaml`         | Checks if a system reboot is required.                                      |
| `reboot.yaml`               | Reboots the system if needed.                                               |
| `update.yaml`               | Updates system packages and security patches.                               |
| `deploy-prometheus.yaml`    | Deploys or syncs the Prometheus configuration files from the Git repo.      |
| `deploy-loki-config.yaml`   | Deploys Loki's configuration (`config.yaml`) from Git to the VM.            |

---

### Applications (`app/`)

Contains Helm repositories and Kustomize configurations for all applications deployed in the cluster.

| Directory         | Description                                                               |
| ----------------- | ------------------------------------------------------------------------- |
| `base/podinfo/`   | Helm repo and kustomization for the **Podinfo** service.                  |
| `base/traefik/`   | Helm repo and kustomization for **Traefik** ingress controller.           |
| `base/promtail/`  | Helm repo and kustomization for **Promtail**, the log forwarder.          |
| `kustomization.yaml` | Kustomize root for base application deployment configs.                |

---

### Cluster Configuration (`cluster/`)

FluxCD configuration for managing environments, namespaces, applications, and alerts.

#### Flux System (`cluster/flux-system/`)

| File                   | Description                                    |
| ---------------------- | ---------------------------------------------- |
| `gotk-components.yaml` | Core FluxCD components.                        |
| `gotk-sync.yaml`       | Git repository sync configuration.             |
| `kustomization.yaml`   | Manages the overall state of the cluster.      |

#### Notifications (`cluster/flux-system/notifications/`)

| File                          | Description                                 |
| ----------------------------- | ------------------------------------------- |
| `discord-provider.yaml`       | Defines Discord as an alerting provider.    |
| `discord-webhook-secret.yaml` | Secret storing the webhook URL.             |
| `flux-alert.yaml`             | Configures alerts for GitOps activity.      |

#### Production Environment (`cluster/prod/`)

| File                         | Description                                           |
| ---------------------------- | ----------------------------------------------------- |
| `kustomization.yaml`         | Aggregates all production-specific resources.         |
| `podinfo-namespace.yaml`     | Namespace definition for Podinfo.                     |
| `podinfo-helmrelease.yaml`   | HelmRelease for deploying Podinfo.                    |
| `podinfo-ingressroute.yaml`  | Traefik ingress for Podinfo.                          |
| `traefik-namespace.yaml`     | Namespace for Traefik.                                |
| `traefik-helmrelease.yaml`   | HelmRelease for Traefik ingress controller.           |
| `traefik-ingressroute.yaml`  | Traefik ingress configuration.                        |
| `promtail-namespace.yaml`    | Namespace for Promtail.                               |
| `promtail-helmrelease.yaml`  | HelmRelease for Promtail (for log forwarding to Loki).|

---

### Portainer Stack (`portainer/`)

Services deployed via **Portainer in GitOps mode**, focused on monitoring and CI/CD.

| Directory        | Description                                                     |
| ---------------- | --------------------------------------------------------------- |
| `monitoring/`     | Contains `docker-compose.yml`, `prometheus.yml`, and `config.yaml` for the monitoring stack (**Prometheus**, **Loki**, **Grafana**, **Uptime Kuma**). |
| `semaphore/`      | Ansible/OpenTofu CI/CD UI stack. Includes `.env` files and compose config. |

---

## Notes and Disclaimers

This project was developed with the primary goal of **storing infrastructure and configuration in Git**, automating as much as possible.

- The **only configuration not stored in Git** is **Portainer’s `docker-compose.yaml` .env**, as it contains secrets. (a `sample.env` is provided as a template)
- **TLS is not configured with Traefik**, as it was out of project scope. This can be added later (e.g., with **DuckDNS**).
- It is not recommended to use Flux directly on production all the time, you must have a staging cluster or space before taking changes to production, this is an exercise to practice GitOps principles

---

## Contributing & Advice

Feel free to **use any part of this setup**, **share feedback**, or **open a discussion** on how to improve it further. Contributions and suggestions are always welcome!

---

## License

This project is licensed under the **MIT License**.