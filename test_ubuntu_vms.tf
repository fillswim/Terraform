resource "proxmox_vm_qemu" "test_ubuntu_vms" {

  # Количество
  count       = 3

  # vmid        = 60+count.index

  # Нода Proxmox, на которой будут разворачиваться ВМ-ки
  target_node = "proxmox1"
  # Название ВМ-ок
  name        = "test-ubuntu-vm-${count.index + 1}"
  # Описание
  desc        = "Test_description"

  # Клонируемый образ ВМ
  clone       = "ubuntu-22.04-cloud"

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
  memory      = 4096

  # Тип контроллера SCSI для эмуляции (lsi, lsi53c810, megasas, pvscsi, virtio-scsi-pci, virtio-scsi-single)
  scsihw      = "virtio-scsi-pci"
  # Разрешить загрузку с ide2
  bootdisk    = "ide2"
  # Порядок загрузки
  boot        = "order=virtio0;ide2;net0"

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
    model     = "virtio"
    bridge    = "vmbr0"
  }

  # Настройки IP и шлюза
  ipconfig0   = "ip=192.168.2.6${count.index + 1}/24,gw=192.168.2.1"

  # (Optional) Default User
  # ciuser = "your-username"

  # (Optional) Add your SSH KEY
  # sshkeys = <<EOF
  # #YOUR-PUBLIC-SSH-KEY
  # EOF
}
