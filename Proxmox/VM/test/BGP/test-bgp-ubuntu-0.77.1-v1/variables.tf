variable "cpu_cores" {
  default = {
    "proxmox1" = 4
    "proxmox2" = 6
    "proxmox3" = 4
    "proxmox4" = 6
    "proxmox5" = 6
  }
}
# ================================================
#                     Image Settings
# ================================================

variable "image_name" {
  type    = string
  default = "noble-server-cloudimg-amd64.img"
}

variable "cloud_init_file_name" {
  type    = string
  default = "user_data.yaml"
}

variable "cloud_init_file_datastore" {
  type    = string
  default = "local"
}

# =============================================
#                     Network
# =============================================

variable "vlan" {
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
#                     VM-s
# ================================================

variable "count_vms" {
  type    = number
  default = 1
}

variable "vm_name" {
  type    = string
  default = "test-ubuntu"
}

variable "proxmox_node" {
  type    = string
  default = "proxmox3"
}

variable "memory" {
  type    = number
  default = 4096
}

variable "on_boot" {
  type    = bool
  default = true
}

variable "agent" {
  type    = bool
  default = true
}

variable "stop_on_destroy" {
  type    = bool
  default = true
}

variable "cpu_type" {
  type    = string
  default = "host"
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

variable "root_disk_interface" {
  type    = string
  default = "virtio0"
}

variable "root_disk_iothread" {
  type    = bool
  default = true
}


# будут ли TRIM/UNMAP команды передаваться из гостевой ОС на уровень хранилища
variable "root_disk_discard" {
  type    = string
  default = "ignore"
}

variable "root_disk_backup" {
  type    = bool
  default = true
}
