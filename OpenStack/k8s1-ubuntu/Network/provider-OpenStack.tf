terraform {
  required_version = ">= 0.14.0"
  required_providers {
    openstack = {
      source  = "terraform-provider-openstack/openstack"
      version = "3.0.0"
    }
  }
}

# Configure the OpenStack Provider
provider "openstack" {
  user_name   = var.openstack_user_name
  password    = var.openstack_password
  tenant_name = var.openstack_tenant_name
  auth_url    = var.openstack_auth_url
  region      = var.openstack_region
}

variable "openstack_user_name" {
  type = string
}

variable "openstack_password" {
  type = string
}

variable "openstack_auth_url" {
  type = string
}

variable "openstack_tenant_name" {
  type = string
}

variable "openstack_region" {
  type = string
}

