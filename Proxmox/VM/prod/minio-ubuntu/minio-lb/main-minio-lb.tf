module "minio-lb" {

  source = "/home/fill/Terraform-Modules/Proxmox/Telmate/3.0.1-rc8/v1/instance-protected"

  # General
  count_vms      = var.count_vms
  env            = var.env
  vm_name        = var.vm_name
  proxmox_node   = var.proxmox_node
  clone_vm_image = var.clone_vm_image

  # Network
  subnet_octet_1  = var.subnet_octet_1
  subnet_octet_2  = var.subnet_octet_2
  subnet_octet_3  = var.subnet_octet_3
  subnet_octet_4  = var.subnet_octet_4
  subnet_mask     = var.subnet_mask
  vlan            = var.vlan
  searchdomain    = var.searchdomain

  # VM
  memory    = var.memory
  disk_size = var.disk_size
  onboot    = var.onboot

  # System
  scsihw     = var.scsihw
  boot_order = var.boot_order
  disk_slot  = var.disk_slot
  bootdisk   = var.bootdisk

}
