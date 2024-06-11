locals {
  ntp_ozod_id = 171
  ntp_rzod_id = 175
}

# NTP OZOD
resource "proxmox_vm_qemu" "ntp_ozod_ubuntu" {

  vmid = local.ntp_ozod_id

  # Нода Proxmox, на которой будут разворачиваться ВМ-ки
  target_node = "proxmox1"
  # Название ВМ-ок
  name = "ntp-ozod-${local.ntp_ozod_id}"
  # Описание
  desc = "NTP_OZOD"

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
          size    = "34"
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
  ipconfig0 = "ip=192.168.2.${local.ntp_ozod_id}/24,gw=192.168.2.1"

}

# NTP RZOD
resource "proxmox_vm_qemu" "ntp_rzod_ubuntu" {

  vmid = local.ntp_rzod_id

  # Нода Proxmox, на которой будут разворачиваться ВМ-ки
  target_node = "proxmox1"
  # Название ВМ-ок
  name = "ntp-rzod-${local.ntp_rzod_id}"
  # Описание
  desc = "NTP_RZOD"

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
          size    = "34"
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
  ipconfig0 = "ip=192.168.2.${local.ntp_rzod_id}/24,gw=192.168.2.1"

}
