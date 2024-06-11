locals {
  ntp_ozod_alt_id        = 181
  ntp_rzod_alt_id        = 185
  ntp_client_ozod_alt_id = 182
  ntp_client_rzod_alt_id = 186
}

# NTP OZOD
resource "proxmox_vm_qemu" "ntp_ozod_altlinux" {

  vmid = local.ntp_ozod_alt_id

  # Нода Proxmox, на которой будут разворачиваться ВМ-ки
  target_node = "proxmox1"
  # Название ВМ-ок
  name = "ntp-ozod-alt"
  # Описание
  desc = "NTP_OZOD_ALT"

  # Клонируемый образ ВМ
  clone = "alt-p10-cloud-v9"

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
          size    = "35"
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
  ipconfig0 = "ip=192.168.2.${local.ntp_ozod_alt_id}/24,gw=192.168.2.1"

}

# NTP RZOD
resource "proxmox_vm_qemu" "ntp_rzod_altlinux" {

  vmid = local.ntp_rzod_alt_id

  # Нода Proxmox, на которой будут разворачиваться ВМ-ки
  target_node = "proxmox1"
  # Название ВМ-ок
  name = "ntp-rzod-alt"
  # Описание
  desc = "NTP_RZOD_ALT"

  # Клонируемый образ ВМ
  clone = "alt-p10-cloud-v9"

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
          size    = "35"
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
  ipconfig0 = "ip=192.168.2.${local.ntp_rzod_alt_id}/24,gw=192.168.2.1"

}
