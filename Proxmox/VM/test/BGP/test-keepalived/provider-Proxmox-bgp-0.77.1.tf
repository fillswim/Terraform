terraform {
  required_providers {
    proxmox = {
      source  = "bpg/proxmox"
      version = "0.78.1"
    }
  }
}

provider "proxmox" {
  endpoint  = var.endpoint
  username  = var.proxmox_username
  password  = var.proxmox_password
  insecure  = var.insecure
  ssh {
    agent       = true
    private_key = file(var.proxmox_node_ssh_private_key_file)
    username    = var.proxmox_node_ssh_username
  }
}

variable "endpoint" {
  type = string
}

variable "insecure" {
  type    = bool
  default = true
}

variable "proxmox_username" {
  type = string
}

variable "proxmox_password" {
  type = string
}

variable "proxmox_node_ssh_username" {
  type    = string
  default = "root"
}

variable "proxmox_node_ssh_private_key_file" {
  type    = string
  default = "~/.ssh/id_ed25519"
}