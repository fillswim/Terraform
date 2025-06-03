terraform {

  required_providers {
    vault = {
      source  = "hashicorp/vault"
      # version = "4.5.0"
      version = "5.0.0"
    }
  }
}

provider "vault" {
  address = var.vault_url
  token   = var.vault_token
}

variable "vault_url" {
  type      = string
  sensitive = true
}

variable "vault_token" {
  type      = string
  sensitive = true
}

