resource "proxmox_virtual_environment_download_file" "almalinux_lxc_template" {
  count        = var.count_proxmox_nodes
  node_name    = "proxmox${1 + count.index}"
  content_type = var.lxc_template_type
  datastore_id = var.lxc_template_datastore
  url          = var.lxc_template_url
  file_name    = var.lxc_template_name
}
