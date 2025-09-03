terraform {

  required_providers {
    tls = {
      source = "hashicorp/tls"
      version = "4.1.0"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "2.37.1"
    }
  }
}

provider "tls" {
  
}

provider "kubernetes" {
  config_path = ".kube/config"
}
