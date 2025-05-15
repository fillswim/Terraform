
resource "proxmox_virtual_environment_download_file" "ubuntu_cloud_image" {
  count        = var.count_proxmox_nodes
  node_name    = "proxmox${1 + count.index}"
  content_type = "iso"
  datastore_id = "local"
  url          = "https://cloud-images.ubuntu.com/noble/current/noble-server-cloudimg-amd64.img"
  file_name    = var.image_name
}

