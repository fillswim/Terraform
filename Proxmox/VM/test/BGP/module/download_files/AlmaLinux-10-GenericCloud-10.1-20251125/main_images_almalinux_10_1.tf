module "AlmaLinux_10_GenericCloud_10_1_20251125" {

  source = "/home/fill/Terraform-Modules/Proxmox/bpg/0.77.1/v2/download_file"

  proxmox_node_name = var.proxmox_node_name
  image_url         = var.image_url
  image_name        = var.image_name
  image_type        = var.image_type
}

output "details" {
  value = module.AlmaLinux_10_GenericCloud_10_1_20251125.details
}
