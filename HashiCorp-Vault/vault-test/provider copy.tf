terraform {

  required_providers {
    vault = {
      source  = "hashicorp/vault"
      version = "4.5.0"
    }
  }
}

provider "vault" {
  address = var.vault_url
  token   = var.vault_token
}

variable "vault_url" {
  type = string
}

variable "vault_token" {
  type = string
}
