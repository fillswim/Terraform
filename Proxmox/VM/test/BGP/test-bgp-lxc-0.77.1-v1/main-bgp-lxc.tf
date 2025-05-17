locals {

  # Количество proxmox серверов
  count_proxmox_nodes = var.count_proxmox_nodes

  ip_address  = var.ip_address
  subnet_mask = var.subnet_mask

  # ip_address_test = "192.168.2.235/24"
  # # Вывод: "192.168.2.235"
  # ip_address_without_mask = split("/", local.ip_address_test)[0]
  # # Выводы по октетам:
  # # Вывод: "192"
  # ip_address_test_octet_1 = split(".", local.ip_address_without_mask)[0]
  # # Вывод: "168"
  # ip_address_test_octet_2 = split(".", local.ip_address_without_mask)[1]
  # # Вывод: "2"
  # ip_address_test_octet_3 = split(".", local.ip_address_without_mask)[2]
  # # Вывод: "235"
  # ip_address_test_octet_4 = split(".", local.ip_address_without_mask)[3]

  # разделение IP-адреса на части
  ip_address_part    = split(".", local.ip_address)
  ip_address_octet_4 = local.ip_address_part[3]
  # формирование ID виртуальной машины
  vm_id_start = (local.ip_address_part[1] * 1000000 +
    local.ip_address_part[2] * 1000 +
  local.ip_address_part[3])

  # для IP-адреса в блоке ip_config
  ip_address_and_mask = join("/", [local.ip_address, local.subnet_mask])

  # Формирование имени файла user_data.yaml на сервере Proxmox ("user_data_vmid.yaml"):
  # join("_", ["user_data", local.vm_id_start]) = "user_data_235"
  user_data_file_name = join("_", ["user_data", local.vm_id_start])
  # join(".", [local.user_data_file_name, "yaml"]) = "user_data_235.yaml"
  full_user_data_file_name = join(".", [local.user_data_file_name, "yaml"])

  # Путь для cloud-init диска ("local:iso/noble-server-cloudimg-amd64.img"):
  # join(":", [var.cloud_init_file_datastore, "iso"]) = "local:iso"
  iso_datastore_path = join(":", [var.cloud_init_file_datastore, "iso"])
  # join("/", [local.iso_datastore_path, var.image_name]) = "local:iso/noble-server-cloudimg-amd64.img"
  image_path = join("/", [local.iso_datastore_path, var.image_name])

  # Добавление дополнительных дисков
  # Генерация списка из объектов с дисками [{}, {}, {}]
  extra_disks = [
    for i in range(var.extra_disks_count) : {
      datastore_id = var.extra_disks_datastore_name
      size         = var.extra_disks_size
      interface    = "${var.extra_disks_interface}${i + 1}"
      iothread     = var.extra_disks_iothread
      discard      = var.discard[var.extra_disks_datastore_name]
      backup       = var.extra_disks_backup
    }
  ]

}

resource "proxmox_virtual_environment_container" "lxc" {

  count = var.count_vms

  #   name = "${var.vm_name}-${count.index + 1}"
  # node_name = var.proxmox_node
  # деление индекса вм-ки по модулю 5 (количество proxmox серверов) + 1
  node_name = var.node_splitting ? "proxmox${count.index % local.count_proxmox_nodes + 1}" : var.proxmox_node

  # формирование ID виртуальной машины
  #                    cidrhost(local.ip_address_and_mask, local.ip_address_octet_4 + count.index)     = "192.168.50.235"
  #         split(".", cidrhost(local.ip_address_and_mask, local.ip_address_octet_4 + count.index))[3] = "235"
  vm_id = (split(".", cidrhost(local.ip_address_and_mask, local.ip_address_octet_4 + count.index))[1] * 1000000 +
           split(".", cidrhost(local.ip_address_and_mask, local.ip_address_octet_4 + count.index))[2] * 1000 +
           split(".", cidrhost(local.ip_address_and_mask, local.ip_address_octet_4 + count.index))[3])

  # cpu {
  #   cores        = var.cpu_cores[var.proxmox_node]
  #   architecture = "amd64"
  #   units        = 1
  # }

  # memory {
  #   dedicated = var.memory
  # }

  # root disk
  disk {
    datastore_id = var.root_disk_datastore_name
    size         = var.root_disk_size
  }

  network_interface {
    name    = "eth0"
    bridge  = var.network_bridge
    vlan_id = var.vlan_id
  }

  initialization {

    hostname = "${var.vm_name}-${count.index + 1}"

    ip_config {
      ipv4 {
        #                    cidrhost(local.ip_address_and_mask, local.ip_address_octet_4 + count.index)                      = "192.168.50.235"
        #         join("/", [cidrhost(local.ip_address_and_mask, local.ip_address_octet_4 + count.index), local.subnet_mask]) = "192.168.50.235/24"
        address = join("/", [cidrhost(local.ip_address_and_mask, local.ip_address_octet_4 + count.index), local.subnet_mask])
        gateway = var.gateway
      }
    }

    user_account {
      keys = [
        var.ssh_key_1
      ]
      password = "test-lxc"
    }

    dns {
      servers = var.nameservers
      domain  = var.searchdomain
    }

  }

  console {
    enabled = true
    type    = "console"
  }

  operating_system {

    # Ubuntu 24.04
    # template_file_id = "local:vztmpl/ubuntu-24.04-standard_24.04-2_amd64.tar.zst"
    # type             = "ubuntu"

    # Ubuntu 22.04
    # template_file_id = "local:vztmpl/ubuntu-22.04-standard_22.04-1_amd64.tar.zst"
    # type             = "ubuntu"

    # Rocky Linux 9
    # template_file_id = "local:vztmpl/rockylinux-9-default_20240912_amd64.tar.xz"
    # type             = "centos"

    # CentOS 9 Stream
    # template_file_id = "local:vztmpl/centos-9-stream-default_20240828_amd64.tar.xz"
    # type             = "centos"

    # AlmaLinux 9
    template_file_id = "local:vztmpl/almalinux-9-default_20240911_amd64.tar.xz"
    type             = "centos"

    # Documentation:
    # template_file_id = proxmox_virtual_environment_download_file.latest_ubuntu_22_jammy_lxc_img.id
    # # Or you can use a volume ID, as obtained from a "pvesm list <storage>"
    # # template_file_id = "local:vztmpl/jammy-server-cloudimg-amd64.tar.gz"
  }

}

resource "null_resource" "remote_exec" {

  depends_on = [proxmox_virtual_environment_container.lxc]

  count = var.count_vms

  provisioner "remote-exec" {
    inline = [
      "apt install -y mtr",
      "pct exec ${proxmox_virtual_environment_container.lxc[count.index].vm_id} -- dnf update -y",
      "pct exec ${proxmox_virtual_environment_container.lxc[count.index].vm_id} -- dnf install -y openssh-server",
      "pct exec ${proxmox_virtual_environment_container.lxc[count.index].vm_id} -- systemctl enable sshd",
      "pct exec ${proxmox_virtual_environment_container.lxc[count.index].vm_id} -- systemctl start sshd"
    ]

    connection {
      type        = "ssh"
      user        = "root"
      private_key = file("~/.ssh/id_ed25519")
      host        = "192.168.2.3"
    }
  }
}
