

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
  # vm_id = ( local.ip_part[1] * 1000000 + 
  #           local.ip_part[2] * 1000 + 
  #           local.ip_part[3] + 
  #           count.index)

  # для IP-адреса в блоке ip_config
  ip_address_and_mask = join("/", [local.ip_address, local.subnet_mask])

  # для файла user_data.yaml на сервере Proxmox ("user_data_vmid.yaml")
  user_data_file_name      = join("_", ["user_data", local.vm_id])
  full_user_data_file_name = join(".", [local.user_data_file_name, "yaml"])

  # Путь для cloud-init диска ("local:iso/noble-server-cloudimg-amd64.img")
  iso_datastore_path = join(":", [var.cloud_init_file_datastore, "iso"])
  image_path         = join("/", [local.iso_datastore_path, var.image_name])

  # Добавление дополнительных дисков
  # Генерация списка из объектов с дисками [{}, {}, {}]
  extra_disks = [
    for i in range(var.extra_disks_count) : {
      datastore_id = var.extra_disks_datastore_name
      size         = var.extra_disks_size
      interface    = "${var.extra_disks_interface}${i + 1}"
      iothread     = var.extra_disks_iothread
      discard      = var.discard[var.extra_disks_datastore_name]
      backup       = var.extra_disks_backup
    }
  ]

}

# Вывод ID виртуальной машины
# output "vm_id" {
#   value = local.ip_address_and_mask
# }

# Вывод пути к образам
# output "image_path" {
#   value = local.image_path
# }

# Вывод списка дисков
# output "extra_disks" {
#   value = local.extra_disks
# }

resource "proxmox_virtual_environment_vm" "ubuntu_vm" {

  # address_count = join("/", [local.ip_address + count.index, local.subnet_mask])

  count = var.count_vms

  name      = var.vm_name
  node_name = var.proxmox_node
  # формирование ID виртуальной машины
  # vm_id     = local.vm_id
  # cidrhost(local.ip_address_and_mask, local.ip_part[3] + count.index)
  vm_id = ( local.ip_part[1] * 1000000 + 
            local.ip_part[2] * 1000 + 
            local.ip_part[3] + count.index)

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

  on_boot    = var.on_boot
  protection = var.protection

  initialization {

    user_data_file_id = proxmox_virtual_environment_file.cloud_config.id

    ip_config {
      ipv4 {
        address = cidrhost(local.ip_address_and_mask, local.ip_part[3] + count.index)
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
    size         = var.root_disk_size
    interface    = var.root_disk_interface
    iothread     = var.root_disk_iothread
    discard      = var.discard[var.root_disk_datastore_name]
    backup       = var.root_disk_backup
  }

  # Extra Disks
  # Обход в цикле списка с объектами дисков
  dynamic "disk" {
    for_each = local.extra_disks
    content {
      datastore_id = disk.value.datastore_id
      size         = disk.value.size
      interface    = disk.value.interface
      iothread     = disk.value.iothread
      discard      = disk.value.discard
      backup       = disk.value.backup
    }
  }

  network_device {
    bridge  = var.network_bridge
    vlan_id = var.vlan_id
  }
}
