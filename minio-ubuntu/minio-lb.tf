module "minio-lb" {

  providers = {
    proxmox = proxmox
  }

  source = "github.com/fillswim/Terraform/modules/ubuntu"
  # source = "../modules/ubuntu"

  count_vms = 2
  # octet3 - vlan
  subnet_octet_3 = 2
  # ip
  subnet_octet_4 = 31
  # VLAN
  # vlan           = 42

  vm_name        = "sys-minio-lb"
  clone_vm_image = "ubuntu-22.04-cloud"

  # "prod" или "test"
  env    = "prod"
  onboot = true

  proxmox_node = "proxmox1"

  memory    = 4096
  disk_size = "50"

}
