locals {
  master_start_id = 61
  master_count = 3
  worker_start_id = 64
  worker_count = 2
}

resource "proxmox_vm_qemu" "k8s1_ol_masters" {

  # Количество
  count       = local.master_count

  # 1000 - prod
  # 2000 - test
  vmid        = 1000 + local.master_start_id + count.index

  # Нода Proxmox, на которой будут разворачиваться ВМ-ки
  target_node = "proxmox2"
  # Название ВМ-ок
  name        = "k8s1-ol-master-${count.index + 1}"
  # Описание
  desc        = "k8s1-ol-master-${count.index + 1}"

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
  scsihw      = "virtio-scsi-single"
  # Разрешить загрузку с ide2
  bootdisk    = "ide2"
  # Порядок загрузки
  boot        = "order=scsi0;ide2;net0"

  # Создать virtio0 диск
  disks {
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
  ipconfig0   = "ip=192.168.2.${local.master_start_id + count.index}/24,gw=192.168.2.1"

  lifecycle {
    ignore_changes = [ boot, bootdisk, ciuser, qemu_os, sshkeys ]
  }

}

resource "proxmox_vm_qemu" "k8s1_ol_workers" {

  # Количество
  count       = local.worker_count

  # 1000 - prod
  # 2000 - test
  vmid        = 1000 + local.worker_start_id + count.index

  # Нода Proxmox, на которой будут разворачиваться ВМ-ки
  target_node = "proxmox2"
  # Название ВМ-ок
  name        = "k8s1-ol-worker-${count.index + 1}"
  # Описание
  desc        = "k8s1-ol-worker-${count.index + 1}"

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
  scsihw      = "virtio-scsi-single"
  # Разрешить загрузку с ide2
  bootdisk    = "ide2"
  # Порядок загрузки
  boot        = "order=scsi0;ide2;net0"

  # Создать virtio0 диск
  disks {
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
  ipconfig0   = "ip=192.168.2.${local.worker_start_id + count.index}/24,gw=192.168.2.1"

  lifecycle {
    ignore_changes = [ boot, bootdisk, ciuser, qemu_os, sshkeys ]
  }

}
