
resource "proxmox_virtual_environment_download_file" "ubuntu_cloud_image" {
  content_type = "iso"
  datastore_id = "local"
  node_name    = "proxmox1"
  url          = "https://cloud-images.ubuntu.com/noble/current/noble-server-cloudimg-amd64.img"
  file_name    = "noble-server-cloudimg-amd64.img"
}

# terraform destroy --target=proxmox_virtual_environment_vm.ubuntu_vm

resource "proxmox_virtual_environment_vm" "ubuntu_vm" {
  name      = "test-ubuntu"
  node_name = "proxmox1"
  vm_id     = 100

  # should be true if qemu agent is not installed / enabled on the VM
  stop_on_destroy = true

#   agent {
#     enabled = true
#   }

  cpu {
    cores = 4
  }

  memory {
    dedicated = 4096
  }


  initialization {
    user_account {
      # do not use this in production, configure your own ssh key instead!
      username = "ubuntu"
      password = "ubuntu"
      keys = [
        var.ssh_key_1
      ]
    }
    ip_config {
      ipv4 {
        address = "192.168.2.235/24"
        gateway = "192.168.2.1"
      }
    }
  }

  disk {
    datastore_id = "local-lvm"
    file_id      = proxmox_virtual_environment_download_file.ubuntu_cloud_image.id
    interface    = "virtio0"
    iothread     = true
    discard      = "on"
    size         = 20
  }

  network_device {
    bridge = "vmbr0"
  }

}
