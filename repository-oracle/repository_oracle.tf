locals {
  repository_oracle_id = 19
  proxmox_node  = "proxmox3"
}

resource "proxmox_vm_qemu" "repository_oracle" {

  # 1000 - prod
  # 2000 - test
  vmid = 1000 + local.repository_oracle_id

  # Нода Proxmox, на которой будут разворачиваться ВМ-ки
  target_node = local.proxmox_node

  # Название ВМ-ок
  name = "repository-oracle"
  # Описание
  desc = "repository-oracle"

  # Клонируемый образ ВМ
  clone = "oracle-linux-9.4-cloud"

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
  memory = 8192

  # Тип контроллера SCSI для эмуляции (lsi, lsi53c810, megasas, pvscsi, virtio-scsi-pci, virtio-scsi-single)
  scsihw = "virtio-scsi-single"
  # Разрешить загрузку с ide2
  bootdisk = "ide2"
  # Порядок загрузки
  boot = "order=scsi0;ide2;net0"

  # Создать virtio0 диск
  disks {
    scsi {
      scsi0 {
        disk {
          storage = "local-lvm"
          size    = "50"
        }
      }
      scsi1 {
        disk {
          storage = "HDD"
          size    = "500"
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
  ipconfig0 = "ip=192.168.2.${local.repository_oracle_id}/24,gw=192.168.2.1"

  lifecycle {
    prevent_destroy = true
    ignore_changes = [boot, bootdisk, ciuser, qemu_os, sshkeys]
  }

}
