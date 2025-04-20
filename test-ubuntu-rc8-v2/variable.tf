variable "start_vmid" {
  default = {
    "prod" = 1000
    "test" = 2000
  }
}

variable "cpu_cores" {
  default = {
    "proxmox1" = 4
    "proxmox2" = 6
    "proxmox3" = 4
    "proxmox4" = 6
  }
}

# Network 
variable "subnet_octet_1" {
  default = 192
}

variable "subnet_octet_2" {
  default = 168
}

variable "subnet_octet_3" {
  default = 2
}

variable "subnet_octet_4" {
  default = 71
}

variable "subnet_mask" {
  default = 24
}

variable "gateway_octet_4" {
  default = 1
}

variable "vlan" {
  # default = -1
  default = 0
}

variable "count_vms" {
  default = 1
}

variable "env" {
  default = "test"
}

variable "vm_name" {
  default = "test-ubuntu"
}

variable "proxmox_node" {
  default = "proxmox3"
}

variable "clone_vm_image" {
  default = "ubuntu-22.04-cloud"
}

# type = "serial0"
variable "vga_type" {
  default = "virtio"
}

variable "memory" {
  default = 4096
}

variable "disk_size" {
  default = "50"
}

variable "onboot" {
  default = false
}
