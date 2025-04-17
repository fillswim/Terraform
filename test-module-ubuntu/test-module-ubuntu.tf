module "test-ubuntu" {

  source          = "/home/fill/Terraform-Modules/Proxmox/Telmate/3.0.1-rc4/v1/instance"

  count_vms       = var.count_vms
  subnet_octet_1  = var.subnet_octet_1
  subnet_octet_2  = var.subnet_octet_2
  subnet_octet_3  = var.subnet_octet_3
  subnet_octet_4  = var.subnet_octet_4
  subnet_mask     = var.subnet_mask
  gateway_octet_4 = var.gateway_octet_4
  vlan            = var.vlan
  env             = var.env
  vm_name         = var.vm_name
  proxmox_node    = var.proxmox_node
  clone_vm_image  = var.clone_vm_image
  vga_type        = var.vga_type
  memory          = var.memory
  disk_size       = var.disk_size
  onboot          = var.onboot
}

output "details" {
  value = module.test-ubuntu.details
}
