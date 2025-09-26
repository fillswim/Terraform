terraform {
  required_providers {
    tls = {
      source  = "hashicorp/tls"
      version = "4.1.0"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "2.37.1"
    }
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
}

provider "kubernetes" {
  config_path = "../.kube/config"
}

provider "tls" {

}
