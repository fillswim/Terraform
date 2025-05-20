module "ubuntu_24_04" {
  source = "/home/fill/Terraform-Modules/Proxmox/bpg/0.77.1/v1/download_file"

  image_url           = var.image_url
  image_name          = var.image_name
  image_type          = var.image_type
}

output "details" {
  value = module.ubuntu_24_04.details
}