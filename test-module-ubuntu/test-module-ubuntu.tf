module "test-ubuntu" {

  providers = {
    proxmox = proxmox.my_proxmox
  }

  source    = "../modules/ubuntu"
  count_vms = 1
  ip        = 254

  vm_name        = "test1-ubuntu"
  clone_vm_image = "ubuntu-22.04-cloud"

  # "prod" или "test"
  env = "test"

  proxmox_node = "proxmox2"

  memory    = 4096
  disk_size = "50"
}
