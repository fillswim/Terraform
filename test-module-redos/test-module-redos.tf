module "test-redos" {

  providers = {
    proxmox = proxmox.my_proxmox
  }

  source    = "../modules/redos"
  count_vms = 1
  ip        = 252

  vm_name        = "test1-redos"
  clone_vm_image = "redos-7.3.4-cloud"

  # "prod" или "test"
  env = "test"

  proxmox_node = "proxmox2"

  memory    = 4096
  disk_size = "50"
}
