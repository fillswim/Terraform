terraform {

  required_version = ">= 0.13.0"

  required_providers {
    proxmox = {
      # source = "Telmate/proxmox"
      source = "telmate/proxmox"
      # version = "~> 2.0"
      # version = "2.9.14"
      # version = "3.0.1-rc1"
      # version = "3.0.1-rc3"
      version = "3.0.1-rc4"
    }
  }
}

variable "TF_LOG" {
  type    = string
  default = "trace"
}

variable "TF_LOG_PATH" {
  type    = string
  default = "./terraform.log"
}

variable "proxmox_api_url" {
  type = string
}

variable "proxmox_api_token_id" {
  type = string
}

variable "proxmox_api_token_secret" {
  type = string
}

provider "proxmox" {

  pm_api_url          = var.proxmox_api_url
  pm_api_token_id     = var.proxmox_api_token_id
  pm_api_token_secret = var.proxmox_api_token_secret

  pm_debug = true
  alias    = "my_proxmox"

  # (Optional) Skip TLS Verification
  # pm_tls_insecure = true

}
