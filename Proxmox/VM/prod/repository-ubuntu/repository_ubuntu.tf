locals {
  repository_ubuntu_id = 18
  proxmox_node         = "proxmox3"
}

# NTP OZOD
resource "proxmox_vm_qemu" "repository_ubuntu" {

  # 1000 - prod
  # 2000 - test
  vmid = 1000 + local.repository_ubuntu_id

  # Нода Proxmox, на которой будут разворачиваться ВМ-ки
  target_node = local.proxmox_node

  # Название ВМ-ок
  name = "repository-ubuntu"
  # Описание
  desc = "Repository Ubuntu"

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
  cores   = 4
  sockets = 1
  cpu     = "host"

  # Настройки оперативная память
  memory = 4096

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
          storage = "HDD"
          size    = "1000"
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
  ipconfig0 = "ip=192.168.2.${local.repository_ubuntu_id}/24,gw=192.168.2.1"

  lifecycle {
    prevent_destroy = true
    ignore_changes = [boot, bootdisk, ciuser, qemu_os, sshkeys]
  }

}
