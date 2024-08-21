module "test-ubuntu" {

  providers = {
    proxmox = proxmox.my_proxmox
  }

  source    = "../modules/ubuntu"
  count_vms = 3
  ip        = 251

  vm_name        = "test1-ubuntu"
  clone_vm_image = "ubuntu-22.04-cloud"

  # "prod" или "test"
  env = "test"

  proxmox_node = "proxmox3"

  cpu_cores = 6
  memory    = 4096
  disk_size = "50"
}
