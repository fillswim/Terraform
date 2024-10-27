locals {
  vlan           = 55
  clone_vm_image = "ubuntu-22.04-cloud"
  env            = "test"
  onboot         = false
  proxmox_node   = "proxmox3"
}

module "sys-adm" {

  providers = {
    proxmox = proxmox.my_proxmox
  }

  source = "github.com/fillswim/Terraform/modules/ubuntu"

  count_vms = 1
  # octet3 - vlan
  subnet_octet_3 = local.vlan
  # ip
  subnet_octet_4 = 21
  # VLAN
  vlan = local.vlan

  vm_name        = "sys-adm"
  clone_vm_image = local.clone_vm_image

  # "prod" или "test"
  env    = local.env
  onboot = local.onboot

  proxmox_node = local.proxmox_node

  memory    = 4096
  disk_size = "50"

}

module "k8s-cpl" {

  providers = {
    proxmox = proxmox.my_proxmox
  }

  source = "github.com/fillswim/Terraform/modules/ubuntu"

  count_vms = 3
  # octet3 - vlan
  subnet_octet_3 = local.vlan
  # ip
  subnet_octet_4 = 31
  # VLAN
  vlan = local.vlan

  vm_name        = "k8s-cpl"
  clone_vm_image = local.clone_vm_image

  # "prod" или "test"
  env    = local.env
  onboot = local.onboot

  proxmox_node = local.proxmox_node

  memory    = 4096
  disk_size = "50"

}

module "k8s-app" {

  providers = {
    proxmox = proxmox.my_proxmox
  }

  source = "github.com/fillswim/Terraform/modules/ubuntu"

  count_vms = 3
  # octet3 - vlan
  subnet_octet_3 = local.vlan
  # ip
  subnet_octet_4 = 34
  # VLAN
  vlan = local.vlan

  vm_name        = "k8s-app"
  clone_vm_image = local.clone_vm_image

  # "prod" или "test"
  env    = local.env
  onboot = local.onboot

  proxmox_node = local.proxmox_node

  memory    = 8192
  disk_size = "50"

}

