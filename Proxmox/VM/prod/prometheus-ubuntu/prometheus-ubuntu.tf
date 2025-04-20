module "prometheus-ubuntu" {

  providers = {
    proxmox = proxmox.my_proxmox
  }

  source = "github.com/fillswim/Terraform/modules/ubuntu"
  # source = "../modules/ubuntu"

  count_vms = 1
  # octet3 - vlan
  subnet_octet_3 = 2
  # ip
  subnet_octet_4 = 43
  # VLAN
  # vlan           = 42

  vm_name        = "prometheus"
  clone_vm_image = "ubuntu-22.04-cloud"

  # "prod" или "test"
  env    = "prod"
  onboot = true

  proxmox_node = "proxmox1"

  memory    = 8192
  disk_size = "50"

}
