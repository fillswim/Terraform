module "dns-proxmox1" {

  source = "/home/fill/Terraform-Modules/Proxmox/Telmate/3.0.1-rc8/v1/instance"

  # Различные переменные для каждого DNS
  vm_name        = var.dns_1_vm_name
  proxmox_node   = var.dns_1_proxmox_node
  subnet_octet_4 = var.dns_1_subnet_octet_4

  # General
  count_vms      = var.count_vms
  env            = var.env
  clone_vm_image = var.clone_vm_image

  # Network
  subnet_octet_1 = var.subnet_octet_1
  subnet_octet_2 = var.subnet_octet_2
  subnet_octet_3 = var.subnet_octet_3
  subnet_mask    = var.subnet_mask
  vlan           = var.vlan
  searchdomain   = var.searchdomain

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

module "dns-proxmox3" {

  source = "/home/fill/Terraform-Modules/Proxmox/Telmate/3.0.1-rc8/v1/instance"

  # Различные переменные для каждого DNS
  vm_name        = var.dns_2_vm_name
  proxmox_node   = var.dns_2_proxmox_node
  subnet_octet_4 = var.dns_2_subnet_octet_4

  # General
  count_vms      = var.count_vms
  env            = var.env
  clone_vm_image = var.clone_vm_image

  # Network
  subnet_octet_1 = var.subnet_octet_1
  subnet_octet_2 = var.subnet_octet_2
  subnet_octet_3 = var.subnet_octet_3
  subnet_mask    = var.subnet_mask
  vlan           = var.vlan
  searchdomain   = var.searchdomain

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
