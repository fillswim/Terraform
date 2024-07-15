locals {
  start_id = 70
  count = 1
}

resource "proxmox_vm_qemu" "test_oracle_linux" {

  # Количество
  count       = local.count

  # 1000 - prod
  # 2000 - test
  vmid        = 2000 + local.start_id + count.index

  # Нода Proxmox, на которой будут разворачиваться ВМ-ки
  target_node = "proxmox2"
  # Название ВМ-ок
  name        = "test-oracle-linux-${count.index + 1}"
  # Описание
  desc        = "test-oracle-linux-${count.index + 1}"

  # Клонируемый образ ВМ
  clone       = "oracle-linux-9.4-cloud"

  # Следует ли запускать виртуальную машину после запуска узла PVE
  onboot      = true

  # VM Cloud-Init Settings
  os_type     = "cloud-init"
  # Место хранения Cloud-Init образа
  cloudinit_cdrom_storage = "local-lvm"

  # Включить гостевой агент
  agent       = 1

  # Настройки CPU
  cores       = 4
  sockets     = 1
  cpu         = "host"

  # Настройки оперативная память
  memory      = 8192

  # Тип контроллера SCSI для эмуляции (lsi, lsi53c810, megasas, pvscsi, virtio-scsi-pci, virtio-scsi-single)
  # scsihw      = "virtio-scsi-pci"
  scsihw      = "virtio-scsi-single"
  # Разрешить загрузку с ide2
  bootdisk    = "ide2"
  # Порядок загрузки
  # boot        = "order=virtio0;ide2;net0"
  boot        = "order=scsi0;ide2;net0"

  # Создать virtio0 диск
  disks {
    # virtio {
    #   virtio0 {
    #     disk {
    #       storage = "local-lvm"
    #       size    = "34"
    #     }
    #   }
    # }
    scsi {
      scsi0 {
        disk {
          storage = "local-lvm"
          size    = "50"
        }
      }
    }
  }

  # Конфигурация сети
  network {
    model     = "virtio"
    bridge    = "vmbr0"
  }

  # Настройки IP и шлюза
  ipconfig0   = "ip=192.168.2.${local.start_id + count.index}/24,gw=192.168.2.1"

  # (Optional) Default User
  # ciuser = "your-username"

  # (Optional) Add your SSH KEY
  # sshkeys = <<EOF
  # #YOUR-PUBLIC-SSH-KEY
  # EOF

  lifecycle {
    ignore_changes = [ boot, bootdisk, ciuser, qemu_os, sshkeys ]
  }

}
