terraform {
  required_providers {
    proxmox = {
      source  = "bpg/proxmox"
      version = "0.77.1"
    }
  }
}

provider "proxmox" {
  endpoint  = var.endpoint
  api_token = var.api_token
  insecure  = var.insecure
  ssh {
    agent       = true
    private_key = file("~/.ssh/id_ed25519")
    username    = "root"
  }
}

variable "endpoint" {
  type = string
}

variable "api_token" {
  type = string
}

variable "insecure" {
  type    = bool
  default = true
}
