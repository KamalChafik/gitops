# 📌 Flux GitOps Project

## 📖 Table of Contents

- [Overview](#overview)
  - [💻 Machines & Hardware](#machines--hardware)
  - [🔧 Services](#services)
  - [🎨 Design](#design)
- [Project Structure](#project-structure)
  - [🔧 Ansible](#ansible)
  - [🚀 Applications (`app/`)](#applications-app)
  - [🌍 Cluster Configuration (`cluster/`)](#cluster-configuration-cluster)
  - [📦 Portainer Stack (`portainer/`)](#portainer-stack-portainer)
- [🔗 Notes and Disclaimers](#notes-and-disclaimers)
- [💡 Contributing & Advice](#contributing--advice)
- [📄 License](#license)

---

## 📝 Overview

This project is a **GitOps-driven Kubernetes setup** using **FluxCD** to manage infrastructure and applications. It integrates automated deployments, monitoring, logging, and follows Infrastructure as Code (IaC) best practices to ensure **reliability, scalability, and maintainability**.

### 💻 **Machines & Hardware**

This project runs on **Linode Kubernetes Engine (LKE)** with a **3-node Kubernetes cluster** and a separate **Ubuntu VM** for infrastructure management.

- **Kubernetes Cluster (3 Nodes on Linode LKE)**
  - Runs all deployed applications using **FluxCD, Helm, and ITOps**.

- **Ubuntu VM**
  - Used for **monitoring, provisioning infrastructure, and cluster configuration**.
  - Hosts **Portainer** for deploying and managing services. (GitOps mode)

### 🔧 **Services**

#### **Kubernetes Cluster (LKE - 3 Nodes)**

- **FluxCD** – GitOps-based Kubernetes deployment automation.
- **Helm** – Package management for Kubernetes applications.
- **ITOps** – Infrastructure management through automation.
- **Traefik** – Ingress controller for managing external traffic.
- **Podinfo** – Example application for testing deployments.
- **Prometheus & Grafana** – Monitoring and metrics visualization (**In Progress**).
- **Loki** – Centralized logging solution (**In Progress**).
- **Discord Notifications** – Real-time updates for GitOps events (**In Progress**).

#### **Ubuntu VM**

- **OpenTofu** – Open-source alternative to Terraform.
- **Ansible** – Configuration management and automation.
- **Portainer** – Container management and deployment in **GitOps mode** with the repository linked.
- **Gatus** – Automated uptime monitoring (**In Progress**).
- **Semaphore** – CI/CD pipeline management with UI for **Ansible and OpenTofu**.

### 🎨 **Design**

This system follows best practices in **GitOps and Infrastructure as Code (IaC)**:

- **Declarative Configuration** – Every deployment and configuration is defined in Git.
- **Immutable Infrastructure** – Updates are applied via GitOps rather than manual intervention.
- **Scalability & High Availability** – Services are distributed across multiple nodes for redundancy.
- **Security & Observability** – Logging, monitoring, and alerting are integrated for complete visibility.

---

## 📂 Project Structure

### 🔧 **Ansible** (`ansible/playbooks/`)

Contains Ansible playbooks for managing system updates and reboots. The goal is to **automate infrastructure provisioning**, but for now, it focuses on **maintenance tasks**.

| File                | Description                                                               |
| ------------------- | ------------------------------------------------------------------------- |
| `check-reboot.yaml` | Checks if a system reboot is required (**Discord notification in progress**). |
| `reboot.yaml`       | Reboots the system if needed.                                             |
| `update.yaml`       | Updates system packages and security patches.                             |

---

### 🚀 **Applications (`app/`)**

Contains Helm repositories and Kustomize configurations for deployed applications.

| Directory          | Description                                                           |
| ------------------ | --------------------------------------------------------------------- |
| `base/podinfo/`   | Helm repository and Kustomization for **Podinfo** service.            |
| `base/traefik/`   | Helm repository and Kustomization for **Traefik** Ingress Controller. |
| `kustomization.yaml` | Manages application deployments via Kustomize.                        |

---

### 🌍 **Cluster Configuration (`cluster/`)**

Manages **FluxCD system components**, namespaces, and production/staging environments.

#### **🔹 Flux System (`cluster/flux-system/`)**

| File                   | Description                                    |
| ---------------------- | ---------------------------------------------- |
| `gotk-components.yaml` | FluxCD core components.                        |
| `gotk-sync.yaml`       | Sync configuration for FluxCD.                 |
| `kustomization.yaml`   | Kustomize settings for managing cluster state. |

#### **🔹 Notifications (`cluster/flux-system/notifications/`)**

| File                          | Description                                 |
| ----------------------------- | ------------------------------------------- |
| `discord-provider.yaml`       | Defines Discord as a notification provider. |
| `discord-webhook-secret.yaml` | Stores the Discord webhook URL as a secret. |
| `flux-alert.yaml`             | Configures alerts for FluxCD events.        |

#### **🔹 Production (`cluster/prod/`)**

| File                        | Description                                     |
| --------------------------- | ----------------------------------------------- |
| `kustomization.yaml`        | Defines production-specific Kustomizations.     |
| `podinfo-helmrelease.yaml`  | HelmRelease for **Podinfo** app.                |
| `podinfo-ingressroute.yaml` | IngressRoute for **Podinfo** service.           |
| `traefik-helmrelease.yaml`  | HelmRelease for **Traefik** Ingress Controller. |
| `traefik-ingressroute.yaml` | IngressRoute for **Traefik**.                   |

#### **🔹 Staging (`cluster/staging/`)**

Placeholder for staging environment configurations.

---

### 📦 **Portainer Stack (`portainer/`)**

Contains monitoring and logging tools.

| Directory     | Description                         |
| ------------- | ----------------------------------- |
| `gatus/`      | Service uptime monitoring.          |
| `grafana/`    | Dashboards for visualizing metrics. |
| `loki/`       | Centralized logging system.         |
| `prometheus/` | Metrics collection and alerting.    |
| `semaphore/`  | UI for **Ansible and OpenTofu**.    |

---

## 📊 **Code Quality & Linting**

To ensure high code quality and maintain consistency, **YAML files are linted using `yamllint`** before deployment. This helps catch misconfigurations and enforce best practices.

### **Running `yamllint` Locally**
To manually check your YAML files:
```sh
pip install yamllint  # Install yamllint if not already installed
yamllint .  # Run yamllint on all YAML files in the repository
```

### **Automated Linting in CI/CD**
- `yamllint` is integrated into the CI/CD pipeline to prevent misconfigured YAML files from being deployed.
- Linting is performed on all `.yaml` and `.yml` files before merging changes into the main branch.

## 🔗 **Notes and Disclaimers**

This project was developed with the primary goal of **storing infrastructure and configuration in Git**, automating as much as possible.

- The **only configuration not stored in Git** is **Portainer’s `docker-compose.yaml`**, as it contains secrets.
- **TLS is not configured with Traefik**, as it was not within the project scope. However, it can be easily added later (possibly with **DuckDNS**).

---

## 💡 **Contributing & Advice**

Feel free to **use any part of this setup**, **share feedback**, or just **start a discussion** about improvements! 🚀

---

## 📄 **License**

This project is licensed under the **MIT License**.