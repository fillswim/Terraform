variable "start_vmid" {
  default = {
    "prod" = 1000
    "test" = 2000
  }
}

variable "count_vms" {
  default = 1
}

variable "ip" {
  default = 71
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

variable "cpu_cores" {
  default = 6
}

variable "clone_vm_image" {
  default = "ubuntu-22.04-cloud"
}

variable "memory" {
  default = 4096
}

variable "disk_size" {
  default = "50"
}
