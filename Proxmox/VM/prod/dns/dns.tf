module "dns-proxmox1" {

  providers = {
    proxmox = proxmox.my_proxmox
  }

  # source = "github.com/fillswim/Terraform/modules/ubuntu"
  source = "../modules/ubuntu"

  count_vms = 1
  # octet3 - vlan
  subnet_octet_3 = 2
  # ip
  subnet_octet_4 = 11
  # VLAN
  # vlan           = 42

  vm_name        = "dns-proxmox1"
  clone_vm_image = "ubuntu-22.04-cloud"

  # "prod" или "test"
  env    = "prod"
  onboot = true

  proxmox_node = "proxmox1"

  memory    = 4096
  disk_size = "50"

}

module "dns-proxmox3" {

  providers = {
    proxmox = proxmox.my_proxmox
  }

  # source = "github.com/fillswim/Terraform/modules/ubuntu"
  source = "../modules/ubuntu"

  count_vms = 1
  # octet3 - vlan
  subnet_octet_3 = 2
  # ip
  subnet_octet_4 = 12
  # VLAN
  # vlan           = 42

  vm_name        = "dns-proxmox3"
  clone_vm_image = "ubuntu-22.04-cloud"

  # "prod" или "test"
  env    = "prod"
  onboot = true

  proxmox_node = "proxmox3"

  memory    = 4096
  disk_size = "50"

}
