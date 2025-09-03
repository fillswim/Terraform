terraform {
  required_providers {
    helm = {
      source  = "hashicorp/helm"
      version = "3.0.2"
    }
  }
}

provider "helm" {
  kubernetes = {
    config_path = "../.kube/config"
  }
  registries = [
    {
      name     = "ghcr.io"
      url      = "https://ghcr.io"
      username = var.ghcr_username
      password = var.ghcr_password
    }
  ]
}

variable "ghcr_username" {
  type = string
}

variable "ghcr_password" {
  type = string
}
