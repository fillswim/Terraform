module "test-ubuntu" {

  providers = {
    proxmox = proxmox.my_proxmox
  }

  source    = "../modules/ubuntu"

  count_vms      = 1
  # octet3 - vlan
  subnet_octet_3 = 2
  # ip
  subnet_octet_4 = 254
  # vlan           = 42

  vm_name        = "test1-ubuntu"
  clone_vm_image = "ubuntu-22.04-cloud"

  # "prod" или "test"
  env = "test"

  proxmox_node = "proxmox3"

  memory    = 4096
  disk_size = "50"

}
