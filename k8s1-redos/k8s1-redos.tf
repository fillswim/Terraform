module "k8s1-redos-cpl" {

  providers = {
    proxmox = proxmox.my_proxmox
  }

  source    = "../modules/redos"
  count_vms = 3
  ip        = 111

  vm_name        = "k8s1-redos-cpl0"
  clone_vm_image = "redos-7.3.4-cloud"

  # "prod" или "test"
  env = "test"

  proxmox_node = "proxmox2"

  memory    = 4096
  disk_size = "50"
}

module "k8s1-redos-app" {

  providers = {
    proxmox = proxmox.my_proxmox
  }

  source    = "../modules/redos"
  count_vms = 2
  ip        = 114

  vm_name        = "k8s1-redos-app0"
  clone_vm_image = "redos-7.3.4-cloud"

  # "prod" или "test"
  env = "test"

  proxmox_node = "proxmox2"

  memory    = 4096
  disk_size = "50"
}
