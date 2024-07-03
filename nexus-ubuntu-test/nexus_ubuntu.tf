locals {
  nexus_ubuntu_id = 43
  proxmox_node    = "proxmox2"
}

# NTP OZOD
resource "proxmox_vm_qemu" "nexus_ubuntu_test" {

  vmid = 1000 + local.nexus_ubuntu_id

  # Нода Proxmox, на которой будут разворачиваться ВМ-ки
  target_node = local.proxmox_node

  # Название ВМ-ок
  name = "nexus-ubuntu"
  # Описание
  desc = "Nexus Ubuntu"

  # Клонируемый образ ВМ
  clone = "ubuntu-22.04-cloud"

  # Следует ли запускать виртуальную машину после запуска узла PVE
  onboot = true

  # VM Cloud-Init Settings
  os_type = "cloud-init"
  # Место хранения Cloud-Init образа
  cloudinit_cdrom_storage = "local-lvm"

  # Включить гостевой агент
  agent = 1

  # Настройки CPU
  cores   = 6
  sockets = 1
  cpu     = "host"

  # Настройки оперативная память
  memory = 8192

  # Тип контроллера SCSI для эмуляции (lsi, lsi53c810, megasas, pvscsi, virtio-scsi-pci, virtio-scsi-single)
  scsihw = "virtio-scsi-pci"
  # Разрешить загрузку с ide2
  bootdisk = "ide2"
  # Порядок загрузки
  boot = "order=virtio0;ide2;net0"

  # Создать virtio0 диск
  disks {
    virtio {
      virtio0 {
        disk {
          storage = "local-lvm"
          size    = "50"
        }
      }
      virtio1 {
        disk {
          storage = "local-lvm"
          size    = "200"
        }
      }
    }
  }

  # Конфигурация сети
  network {
    model  = "virtio"
    bridge = "vmbr0"
  }

  # Настройки IP и шлюза
  ipconfig0 = "ip=192.168.2.${local.nexus_ubuntu_id}/24,gw=192.168.2.1"

  lifecycle {
    ignore_changes = [ bootdisk, ciuser, qemu_os, sshkeys ]
  }

}
