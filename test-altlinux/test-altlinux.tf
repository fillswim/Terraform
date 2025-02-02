locals {

  start_id = 237
  count = 1

}

# OCFS NODES XTP
resource "proxmox_vm_qemu" "test_altlinux" {

  count       = local.count

  vmid        = 2000 + local.start_id + count.index

  # Нода Proxmox, на которой будут разворачиваться ВМ-ки
  target_node = "proxmox3"
  # Название ВМ-ок
  name = "test-altlinux-${count.index + 1}"
  # Описание
  desc = "test-altlinux-${count.index + 1}"

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

  vga {
    type = "std"
  }

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
  ipconfig0 = "ip=192.168.2.${local.start_id + count.index}/24,gw=192.168.2.1"

  lifecycle {
    ignore_changes = [ bootdisk, ciuser, qemu_os, sshkeys, boot ]
  }

}