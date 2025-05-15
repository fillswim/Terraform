
resource "proxmox_virtual_environment_download_file" "ubuntu_cloud_image" {
  count        = var.count_proxmox_nodes
  node_name    = "proxmox${1 + count.index}"
  content_type = var.image_type
  datastore_id = var.image_datastore
  url          = var.image_url
  file_name    = var.image_name
}

