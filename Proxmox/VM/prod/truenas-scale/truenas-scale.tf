locals {
  subnet = "${var.subnet_octet_1}.${var.subnet_octet_2}.${var.subnet_octet_3}"
}

resource "proxmox_vm_qemu" "server" {

  # Количество
  count = var.count_vms

  # 1000 - prod
  # 2000 - test
  vmid = var.env == "prod" ? (var.start_vmid["prod"] + var.subnet_octet_4 + count.index) : (var.start_vmid["test"] + var.subnet_octet_4 + count.index)

  # Нода Proxmox, на которой будут разворачиваться ВМ-ки
  target_node = var.proxmox_node
  # Название ВМ-ок
  name = "${var.vm_name}"
  # Описание
  desc = "${var.vm_name}"

  # Клонируемый образ ВМ
  # clone = var.clone_vm_image

  # Следует ли запускать виртуальную машину после запуска узла PVE
  onboot = var.onboot

  # VM Cloud-Init Settings
  # os_type = "cloud-init"

  # Включить гостевой агент
  # agent = 1

  # Настройки CPU
  cores   = var.cpu_cores[var.proxmox_node]
  sockets = 1
  cpu     = "host"

  # Настройки оперативная память
  memory = var.memory

  # Тип контроллера SCSI для эмуляции 
  # (lsi, lsi53c810, megasas, pvscsi, virtio-scsi-pci, virtio-scsi-single)
  scsihw = "virtio-scsi-pci"
  # Разрешить загрузку с ide0
  bootdisk = "ide0"
  # Порядок загрузки
  boot = "order=virtio0;ide0;net0"

  # Диски
  disks {
    ide {
      ide0 {
        # cloudinit {
        #   storage = "local-lvm"
        # }
        cdrom {
          iso = "local:iso/TrueNAS-SCALE-24.04.2.3.iso"
        }
      }
    }
    virtio {
      virtio0 {
        disk {
          storage = "local-lvm"
          size    = var.disk_size
        }
      }
      virtio1 {
        disk {
          storage = "HDD"
          size    = "500"
        }
      }
      virtio2 {
        disk {
          storage = "HDD"
          size    = "500"
        }
      }
    }
  }


  vga {
    type = var.vga_type
  }

  # Конфигурация сети
  network {
    model  = "virtio"
    bridge = "vmbr0"
    tag    = var.vlan
  }

  # Настройки IP и шлюза
  ipconfig0 = "ip=${local.subnet}.${var.subnet_octet_4 + count.index}/${var.subnet_mask},gw=${local.subnet}.${var.gateway_octet_4}"

  lifecycle {
    prevent_destroy = true
    ignore_changes = [disks, boot, bootdisk, ciuser, qemu_os, sshkeys]
  }

}
