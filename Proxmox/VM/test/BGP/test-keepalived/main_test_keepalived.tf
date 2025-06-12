module "test_keepalived" {

  source = "/home/fill/Terraform-Modules/Proxmox/bpg/0.77.1/v1/instance"

  # ================================================
  #                  SSH Connection
  # ================================================
  ssh_private_key = var.ssh_private_key
  ssh_user        = var.ssh_user
  # ================================================
  #                     VM Settings
  # ================================================
  count_vms       = var.count_vms
  vm_name         = var.vm_name
  proxmox_node    = var.proxmox_node
  memory          = var.memory
  on_boot         = var.on_boot
  agent           = var.agent
  stop_on_destroy = var.stop_on_destroy
  cpu_type        = var.cpu_type
  protection      = var.protection
  # ================================================
  #                     Image Settings
  # ================================================
  image_name                = var.image_name
  cloud_init_file_name      = var.cloud_init_file_name
  cloud_init_file_datastore = var.cloud_init_file_datastore
  # =============================================
  #                     Network
  # =============================================
  vlan_id      = var.vlan_id
  ip_address   = var.ip_address
  subnet_mask  = var.subnet_mask
  gateway      = var.gateway
  nameservers  = var.nameservers
  searchdomain = var.searchdomain
  # ================================================
  #                     Root Disks
  # ================================================
  root_disk_datastore_name = var.root_disk_datastore_name
  root_disk_size           = var.root_disk_size
  root_disk_interface      = var.root_disk_interface
  root_disk_iothread       = var.root_disk_iothread
  root_disk_backup         = var.root_disk_backup
  # ===============================================
  #                   Extra Disks
  # ===============================================
  extra_disks_count     = var.extra_disks_count
  extra_disks_size      = var.extra_disks_size
  extra_disks_interface = var.extra_disks_interface
  extra_disks_iothread  = var.extra_disks_iothread
  extra_disks_backup    = var.extra_disks_backup
}

output "details" {
  value = module.test_keepalived.details
}
