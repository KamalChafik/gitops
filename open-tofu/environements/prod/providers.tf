terraform {
  required_providers {
    linode = {
      source  = "linode/linode"
      version = "~> 1.29"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "~> 2.20"
    }
  }
}

provider "linode" {
  token = var.linode_api_token
}

provider "kubernetes" {
  config_path    = "~/.kube/config"
  config_context = "linode-lke" 
}