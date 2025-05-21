module "lxc_almalinux_9" {
  source = "/home/fill/Terraform-Modules/Proxmox/bpg/0.77.1/v1/lxc"
  # =========================================================
  #                     LXC Settings
  # =========================================================
  count_lxcs                 = var.count_lxcs
  lxc_name                   = var.lxc_name
  proxmox_node               = var.proxmox_node
  node_splitting             = var.node_splitting
  memory                     = var.memory
  cpu_units                  = var.cpu_units
  protection                 = var.protection
  lxc_template_distribution  = var.lxc_template_distribution
  lxc_ssh_public_keys        = var.lxc_ssh_public_keys
  lxc_password               = var.lxc_password
  start_on_boot              = var.start_on_boot
  # =========================================================
  #                     Network
  # =========================================================
  vlan_id                    = var.vlan_id
  ip_address                 = var.ip_address
  subnet_mask                = var.subnet_mask
  gateway                    = var.gateway
  nameservers                = var.nameservers
  searchdomain               = var.searchdomain
  # =========================================================
  #                     Root Disks
  # =========================================================
  root_disk_datastore_name   = var.root_disk_datastore_name
  root_disk_size             = var.root_disk_size
  # =========================================================
  #                   Extra Disks
  # =========================================================
  extra_disks_mount_path     = var.extra_disks_mount_path
  extra_disks_datastore_name = var.extra_disks_datastore_name
  extra_disks_size           = var.extra_disks_size
  extra_disks_backup         = var.extra_disks_backup
  # =========================================================
}

output "details" {
  value = module.lxc_almalinux_9.details
}
