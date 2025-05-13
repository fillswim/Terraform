

resource "proxmox_virtual_environment_file" "cloud_config" {
  node_name    = var.proxmox_node
  datastore_id = var.cloud_init_file_datastore
  content_type = "snippets"
  source_file {
    path      = var.cloud_init_file_name
    file_name = local.full_user_data_file_name
  }
}

# terraform destroy --target=proxmox_virtual_environment_vm.ubuntu_vm

locals {

  ip_address  = var.ip_address
  subnet_mask = var.subnet_mask

  # разделение IP-адреса на части
  ip_part = split(".", local.ip_address)
  # формирование ID виртуальной машины
  vm_id = local.ip_part[1] * 1000000 + local.ip_part[2] * 1000 + local.ip_part[3]

  # для IP-адреса в блоке ip_config
  ip_address_and_mask = join("/", [local.ip_address, local.subnet_mask])

  # для файла user_data.yaml на сервере Proxmox ("user_data_vmid.yaml")
  user_data_file_name      = join("_", ["user_data", local.vm_id])
  full_user_data_file_name = join(".", [local.user_data_file_name, "yaml"])

  # Путь для cloud-init диска ("local:iso/noble-server-cloudimg-amd64.img")
  iso_datastore_path = join(":", [var.cloud_init_file_datastore, "iso"])
  image_path         = join("/", [local.iso_datastore_path, var.image_name])

}

output "vm_id" {
  value = local.ip_address_and_mask
}

output "image_path" {
  value = local.image_path
}

resource "proxmox_virtual_environment_vm" "ubuntu_vm" {

  name      = var.vm_name
  node_name = var.proxmox_node
  vm_id     = local.vm_id

  # should be true if qemu agent is not installed / enabled on the VM
  stop_on_destroy = var.stop_on_destroy

  agent {
    enabled = var.agent
  }

  cpu {
    cores = var.cpu_cores[var.proxmox_node]
    type  = var.cpu_type
  }

  memory {
    dedicated = var.memory
  }

  on_boot = var.on_boot

  initialization {

    user_data_file_id = proxmox_virtual_environment_file.cloud_config.id

    ip_config {
      ipv4 {
        address = local.ip_address_and_mask
        gateway = var.gateway
      }
    }

    dns {
      servers = var.nameservers
      domain  = var.searchdomain
    }


  }

  # root disk
  disk {
    datastore_id = var.root_disk_datastore_name
    file_id      = local.image_path
    interface    = var.root_disk_interface
    iothread     = var.root_disk_iothread
    discard      = var.root_disk_discard
    size         = var.root_disk_size
    backup       = var.root_disk_backup
  }

  network_device {
    bridge = var.network_bridge
  }

}
