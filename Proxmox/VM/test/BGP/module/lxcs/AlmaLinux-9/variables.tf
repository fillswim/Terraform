# =============================================
#                     Network
# =============================================

variable "vlan_id" {
  type    = number
  default = 0
}

variable "network_bridge" {
  type    = string
  default = "vmbr0"
}

variable "ip_address" {
  type = string
}

variable "subnet_mask" {
  type    = string
  default = "24"
}

variable "gateway" {
  type    = string
  default = "192.168.2.1"
}

variable "nameservers" {
  type    = list(string)
  default = ["192.168.2.11", "192.168.2.12"]
}

variable "searchdomain" {
  type    = string
  default = "fillswim.local"
}

# ================================================
#                     LXC Settings
# ================================================

variable "count_lxcs" {
  type    = number
  default = 1
}

variable "lxc_name" {
  type    = string
  default = "test-lxc"
}

variable "proxmox_node" {
  type    = string
  default = "proxmox1"
}

variable "memory" {
  type    = number
  default = 4096
}

variable "cpu_architecture" {
  type    = string
  default = "amd64"
}

variable "cpu_units" {
  type    = number
  default = 1
}

variable "protection" {
  type    = bool
  default = false
}

variable "lxc_template_distribution" {
  type    = string
  default = "ubuntu-24.04"
}

variable "lxc_ssh_public_keys" {
  type = list(string)
}

variable "lxc_password" {
  type = string
}

variable "network_interface_name" {
  type    = string
  default = "eth0"
}

variable "start_on_boot" {
  type    = bool
  default = true
}

variable "console_enabled" {
  type    = bool
  default = true
}

variable "console_type" {
  type    = string
  default = "console"
}

variable "unprivileged" {
  type    = bool
  default = true
}

variable "features_nesting" {
  type    = bool
  default = true
}

# ================================================
#                     Root Disks
# ================================================

variable "root_disk_datastore_name" {
  type    = string
  default = "local-lvm"
}

variable "root_disk_size" {
  type    = number
  default = 20
}

# ===============================================
#                   Node Splitting
# ===============================================

variable "node_splitting" {
  type    = bool
  default = false
}

# ===============================================
#                   Extra Disks
# ===============================================

variable "extra_disks_mount_path" {
  type    = map(string)
  default = {
    "1" = "/mnt/volume1"
    "2" = "/mnt/volume2"
    "3" = "/mnt/volume3"
  }
}

variable "extra_disks_datastore_name" {
  type    = string
  default = "local-lvm"
}

variable "extra_disks_size" {
  type    = string
  default = "10G"
}

variable "extra_disks_backup" {
  type    = bool
  default = true
}




